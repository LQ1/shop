//
//  GoodsDetailViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailViewModel.h"

#import "GoodsDetailService.h"
#import "MineService.h"

#import "GoodsDetailModel.h"
// 优惠信息
#import "GoodsDetailDiscountMsgViewModel.h"
#import "GoodsDetailDiscountItemViewModel.h"
#import "GoodsDetailCouponChooseViewModel.h"
// 商品参数
#import "GoodsDetailPramsViewModel.h"
#import "GoodsDetailPramsDetailViewModel.h"
// 商品运费+标签
#import "GoodsDetailPostageSecViewModel.h"
#import "GoodsDetailPostageViewModel.h"
// 拼团信息
#import "GoodsDetailGroupMsgSecViewModel.h"
#import "GoodsDetailGroupMsgViewModel.h"
// 商品评论
#import "GoodsDetailCommentViewModel.h"
#import "CommentRowItemViewModel.h"
#import "GoodsCommentModel.h"
#import "CommentListViewModel.h"
// 确认订单
#import "ConfirmOrderViewModel.h"
// 商品介绍
#import "GoodsDetailIntroduceViewModel.h"
// 音频播放
#import <AVFoundation/AVFoundation.h>

@interface GoodsDetailViewModel()

@property (nonatomic,assign)GoodsDetailType detailType;
@property (nonatomic,copy)NSString *goods_cat_id;
@property (nonatomic,copy)NSString *activity_flash_id;
@property (nonatomic,copy)NSString *activity_bargain_id;
@property (nonatomic,copy)NSString *activity_group_id;
@property (nonatomic,copy)NSString *storehouse_id;

@property (nonatomic,strong) GoodsDetailService *service;
@property (nonatomic,strong) MineService *mineService;

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) GoodsDetailPramsDetailViewModel *paramsRowViewModel;
@property (nonatomic,strong) GoodsDetailDiscountItemViewModel *disAccountScoreItemVM;

@property (nonatomic,strong) GoodsDetailIntroduceViewModel *introduceVM;

@property (nonatomic,strong) CommentListViewModel *commentListVM;
// 音频播放
@property (nonatomic,strong)AVPlayer * audioPlayer;

@end

@implementation GoodsDetailViewModel

- (instancetype)initWithProductID:(NSString *)productID
                  goodsDetailType:(GoodsDetailType)detailType
                activity_flash_id:(NSString *)activity_flash_id
              activity_bargain_id:(NSString *)activity_bargain_id
                activity_group_id:(NSString *)activity_group_id
{
    self = [super init];
    if (self) {
        self.detailType = detailType;
        self.activity_flash_id = activity_flash_id;
        self.activity_bargain_id = activity_bargain_id;
        self.activity_group_id = activity_group_id;
        
        _tipLoadingSignal = [[RACSubject subject] setNameWithFormat:@"%@ tipLoadingSignal", self.class];
        self.productID = productID;
        self.service = [GoodsDetailService new];
        self.mineService = [MineService new];
    }
    return self;
}

#pragma mark -获取数据
- (void)getData
{
    @weakify(self);
    NSString *activity = nil;
    switch (self.detailType) {
        case GoodsDetailType_SecKill:
        {
            activity = @"flash";
        }
            break;
        case GoodsDetailType_GroupBy:
        {
            activity = @"group";
        }
            break;
        case GoodsDetailType_Bargain:
        {
            activity = @"bargain";
        }
            break;
            
        default:
            break;
    }
    
    // 商品详情
    RACDisposable *disPos = [[self.service getGoodsDetailWithGoodID:[self.productID integerValue]
                                                           activity:activity
                                                  activity_flash_id:self.activity_flash_id
                                                activity_bargain_id:self.activity_bargain_id
                                                  activity_group_id:self.activity_group_id] subscribeNext:^(GoodsDetailModel *model) {
        @strongify(self);
        [self dealDataWithDetailModel:model];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = GoodsDetailViewModel_Signal_Type_GetDataFail;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithDetailModel:(GoodsDetailModel *)model
{
    // --- 头视图 ---
    self.productPrice = [model.price floatValue];
    self.productName = model.goods_title;
    self.score = model.score;
    self.productImageUrls = model.goods_image;
    self.productAudioDescUrl = model.audio;
    self.audio_time = [model.audio_time integerValue];
    self.productVideoDescUrl = model.video;
    self.video_time = [model.video_time integerValue];

    @weakify(self);
    // 拼团倒计时
    if (self.detailType == GoodsDetailType_GroupBy) {
        self.groupMissNum = [model.activity.missing_num integerValue];
        self.activityRemainingTime = [[CommUtls dencodeTime:model.activity.sell_end_at] timeIntervalSinceDate:[NSDate date]];
        [[[RACSignal interval:1. onScheduler:[RACScheduler currentScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.activityRemainingTime>0) {
                self.activityRemainingTime--;
            }
        }];
    }
    
    // 秒杀倒计时
    if (self.detailType == GoodsDetailType_SecKill) {
        self.activityRemainingTime = [[CommUtls dencodeTime:model.activity.sell_end_at] timeIntervalSinceDate:[NSDate date]];
        [[[RACSignal interval:1. onScheduler:[RACScheduler currentScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.activityRemainingTime>0) {
                self.activityRemainingTime--;
            }
        }];
    }
    
    // 商品缩略 分享用
    self.thumb = model.thumb;
    
    // goods_cat_id 获取优惠券用
    self.goods_cat_id = model.goods_cat_id;
    
    // 活动商品货仓id 下单用
    self.storehouse_id = [model.storehouse_id lyStringValue];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // --- 优惠券+积分+返现 ---
    NSMutableArray *disCountArray = [NSMutableArray array];
    // 优惠券
    if ([model.is_coupon integerValue] == 1) {
        GoodsDetailDiscountItemViewModel *discountItemVM1 = [[GoodsDetailDiscountItemViewModel alloc] initWithGoodsDetailDiscountType:GoodsDetailDiscountType_Coupon detail:nil];
        [disCountArray addObject:discountItemVM1];
    }
    // 积分
    self.disAccountScoreItemVM = [[GoodsDetailDiscountItemViewModel alloc] initWithGoodsDetailDiscountType:GoodsDetailDiscountType_Integral detail:@"商品支持使用懒店积分"];
    if ([model.use_score integerValue] > 0) {
        [disCountArray addObject:self.disAccountScoreItemVM];
    }
    // 返现
    if ([model.rebate_percent integerValue]>0 && self.detailType!=GoodsDetailType_Store && [LYAppCheckManager shareInstance].isAppAgree) {
        NSString *cashBackTip = [NSString stringWithFormat:@"分%ld期返还实际支付金额的%ld%%\n返现金额不足50元则分1期即可全部返还\n个人中心查看返现码\n凭返现码至关联店铺返还现金",(long)[model.rebate_times integerValue],(long)[model.rebate_percent integerValue]];
        GoodsDetailDiscountItemViewModel *discountItemVM3 = [[GoodsDetailDiscountItemViewModel alloc] initWithGoodsDetailDiscountType:GoodsDetailDiscountType_CashBack detail:cashBackTip];
        [disCountArray addObject:discountItemVM3];
    }
    
    GoodsDetailDiscountMsgViewModel *disCountVM = [[GoodsDetailDiscountMsgViewModel alloc] initWithItemViewModels:disCountArray];
    
    [resultArray addObject:disCountVM];
    
    // --- 商品sku选择 ---
    GoodsDetailPramsViewModel *pramsVM = [[GoodsDetailPramsViewModel alloc] initWithProductID:self.productID];
    self.paramsRowViewModel = pramsVM.childViewModels.linq_firstOrNil;
    self.paramsRowViewModel.cartType = self.detailType==GoodsDetailType_Store?1:0;
    if ([self isActivity]) {
        self.paramsRowViewModel.isActivity = YES;
        self.paramsRowViewModel.activityAttrValues = model.attr_values;
        self.paramsRowViewModel.goods_sku_id = model.goods_sku_id;
        self.paramsRowViewModel.quantity = 1;
    }
    if (self.fromScan && self.scan_goods_sku_id.length) {
        // 来自扫一扫 要有默认的sku信息
        self.paramsRowViewModel.goods_sku_id = self.scan_goods_sku_id;
        self.paramsRowViewModel.quantity = 1;
        self.paramsRowViewModel.useScanAttr = YES;
        self.paramsRowViewModel.scanAttrValues = self.scan_attr_values;
    }
    // 选择sku后要刷新商品详情
    [[RACObserve(self.paramsRowViewModel, productPrice) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        self.productPrice = [x floatValue];
    }];
    
    RAC(self,score) = [RACObserve(self.paramsRowViewModel, score) skip:1];
    
    [[RACObserve(self.paramsRowViewModel, use_score) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *disAccountArray = [NSMutableArray arrayWithArray:disCountVM.childViewModels];
        if ([x integerValue] == 0) {
            // 不支持积分
            if ([disCountArray containsObject:self.disAccountScoreItemVM]) {
                [disCountArray removeObject:self.disAccountScoreItemVM];
            }
        }else{
            // 支持积分
            if (![disCountArray containsObject:self.disAccountScoreItemVM]) {
                [disCountArray addObject:self.disAccountScoreItemVM];
            }
        }
        disCountVM.childViewModels = [NSArray arrayWithArray:disAccountArray];
    }];
    
    [resultArray addObject:pramsVM];
    
    // --- 运费+标签 ---
    GoodsDetailPostageViewModel *postItemViewModel = [[GoodsDetailPostageViewModel alloc] initWithPostage:model.postage goodsTagModels:model.goods_tag];
    GoodsDetailPostageSecViewModel *postageVM = [[GoodsDetailPostageSecViewModel alloc] initWithGoodsDetailPostageViewModel:postItemViewModel];
    
    [resultArray addObject:postageVM];
    
    // ---  拼团信息  ---
    if (self.detailType == GoodsDetailType_GroupBy) {
        GoodsDetailGroupMsgViewModel *groupMsgVM = [GoodsDetailGroupMsgViewModel new];
        groupMsgVM.missingNum = [NSString stringWithFormat:@"%ld",(long)self.groupMissNum];
        [[[RACObserve(self, activityRemainingTime) takeUntil:self.rac_willDeallocSignal] distinctUntilChanged] subscribeNext:^(id x) {
            groupMsgVM.leftTime = [CommUtls timeToHMS:[x integerValue]];
        }];
        GoodsDetailGroupMsgSecViewModel *groupMsgSecVM = [[GoodsDetailGroupMsgSecViewModel alloc] initWithGroupMsgViewModel:groupMsgVM];
        
        [resultArray addObject:groupMsgSecVM];
    }
    
    // --- 评论 ---
    if (model.goods_comment.count) {
        NSMutableArray *commentsVMArray = [NSMutableArray array];
        [model.goods_comment enumerateObjectsUsingBlock:^(GoodsCommentModel *commentModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentRowItemViewModel *commentItemVM = [[CommentRowItemViewModel alloc] initWithHeaderImgUrl:commentModel.avatar userName:commentModel.nickname commentDetail:commentModel.content commentImageUrls:commentModel.image created_at:commentModel.created_at];
            [commentsVMArray addObject:commentItemVM];
        }];
        GoodsDetailCommentViewModel *commentVM = [[GoodsDetailCommentViewModel alloc] initWithCommentCount:[model.comments integerValue] commentDetails:commentsVMArray];
        
        [resultArray addObject:commentVM];
    }else{
        GoodsDetailCommentViewModel *commentVM = [[GoodsDetailCommentViewModel alloc] initWithCommentCount:0 commentDetails:nil];
        [resultArray addObject:commentVM];
    }
    
    self.dataArray = [NSArray arrayWithArray:resultArray];
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_GetDataSuccess;
    [self.updatedContentSignal sendNext:nil];
}
// 是否活动
- (BOOL)isActivity
{
    if (self.detailType == GoodsDetailType_Bargain||
        self.detailType == GoodsDetailType_GroupBy||
        self.detailType == GoodsDetailType_SecKill) {
        return YES;
    }
    return NO;
}

#pragma mark -列表相关
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (LYItemUIBaseViewModel *)baseUIVMInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *viewModel = [self.dataArray objectAtIndex:section];
    return viewModel;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *viewModel = [self.dataArray objectAtIndex:section];
    return viewModel.UIHeight;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *viewModel = [self.dataArray objectAtIndex:section];
    return viewModel.childViewModels.count;
}

- (LYItemUIBaseViewModel *)baseUIVMAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:indexPath.section];
    return [secVM.childViewModels objectAtIndex:indexPath.row];

}

#pragma mark -跳转sku选择
- (void)gotoPattrnChooseWithConfirmStyle:(BOOL)confirm
                           confirmAction:(int)confirmAction
{
    self.paramsRowViewModel.confirmStyle = confirm;
    self.paramsRowViewModel.confirmAction = confirmAction;
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoPattrnChoose;
    [self.updatedContentSignal sendNext:self.paramsRowViewModel];
}

#pragma mark -跳转优惠券选择
- (void)gotoCouponChoose
{
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoCouponChoose;
    GoodsDetailCouponChooseViewModel *vm = [[GoodsDetailCouponChooseViewModel alloc] initWithGoods_cat_id:self.goods_cat_id];
    [self.updatedContentSignal sendNext:vm];
}

#pragma mark -跳转商品标签详情页
- (void)gotoGoodsTagsDetailAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailPostageSecViewModel *sectionVM = [self.dataArray objectAtIndex:indexPath.section];
    GoodsDetailPostageViewModel *postageVM = [sectionVM.childViewModels objectAtIndex:indexPath.row];
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoGoodsTagsDetail;
    [self.updatedContentSignal sendNext:postageVM.goodsTagModels];
}

#pragma mark -加入购物车
- (void)addToCart
{
    if (![self.paramsRowViewModel hasSelectedSku]) {
        [self gotoPattrnChooseWithConfirmStyle:YES
                                 confirmAction:GoodsPramsConfirmAction_AddToCart];
        return;
    }
    @weakify(self);
    [PublicEventManager judgeLoginToPushWithNavigationController:nil pushBlock:^{
        @strongify(self);
        self.loading = YES;
        RACDisposable *disPos = [[[ShoppingCartService sharedInstance] addGoodsToCartWithGoods_id:self.productID goods_sku_id:self.paramsRowViewModel.goods_sku_id quantity:[NSString stringWithFormat:@"%ld",(long)self.paramsRowViewModel.quantity]] subscribeNext:^(id x) {
            @strongify(self);
            self.loading = NO;
            [self.tipLoadingSignal sendNext:@"已成功加入购物车"];
        } error:^(NSError *error) {
            @strongify(self);
            self.loading = NO;
            [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
        }];
        [self addDisposeSignal:disPos];
    }];
}

#pragma mark -立即XX 根据商品类型有所不同
- (void)immediatelyAction
{
    if (![self.paramsRowViewModel hasSelectedSku]) {
        [self gotoPattrnChooseWithConfirmStyle:YES
                                 confirmAction:GoodsPramsConfirmAction_ImediatelyPay];
        return;
    }
    
    @weakify(self);
    [PublicEventManager judgeLoginToPushWithNavigationController:nil pushBlock:^{
        @strongify(self);
        if (self.detailType == GoodsDetailType_Bargain) {
            // 是否参与砍价
            [self fetchGoodsJoinBargian];
        }else if(self.detailType == GoodsDetailType_GroupBy){
            // 是否参与拼团
            [self fetchGoodsJoinGroup];
        }else{
            // 确认订单
            ConfirmOrderViewModel *vm =
            [[ConfirmOrderViewModel alloc] initWithConfirm_order_from:ConfirmOrderFrom_GoodsDetail
                                                           goods_type:self.detailType
                                                        goods_cart_id:nil
                                                             goods_id:self.productID
                                                         goods_sku_id:self.paramsRowViewModel.goods_sku_id
                                                             quantity:[NSString stringWithFormat:@"%ld",(long)self.paramsRowViewModel.quantity]
                                                    activity_flash_id:self.activity_flash_id
                                                    activity_group_id:self.activity_group_id
             
                                                  activity_bargain_id:nil
                                                      bargain_open_id:nil
                                                        storehouse_id:self.storehouse_id
             reffer_id:self.referee_id];
            
            self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoConfirmOrder;
            [self.updatedContentSignal sendNext:vm];
        }
    }];
}

#pragma mark -立即砍价
// 获取用户是否已参加砍价
- (void)fetchGoodsJoinBargian
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service fetchGoodsJoinBargain:self.activity_bargain_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        @weakify(self);
        LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                        message:@"你在\"我的砍价\"已有此商品砍价进程,是否仍要砍价"
                                                         titles:@[@"前往查看",@"砍价"]
                                                          click:^(NSInteger index) {
                                                              @strongify(self);
                                                              if (index == 0) {
                                                                  // 前往我的砍价
                                                                  self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoMyBargain;
                                                                  [self.updatedContentSignal sendNext:nil];
                                                              }else{
                                                                  // 发起砍价
                                                                  [self startBargain];
                                                              }
                                                          }];
        alert.isOutside = YES;
        [alert show];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        // 发起砍价
        [self startBargain];
    }];
    [self addDisposeSignal:disPos];
}
// 绑定合伙人
- (void)bindPartner {
    if ([self.referee_id length]) {
        RACDisposable *disPos = [[self.service bindPartnerWithScanQRCode:self.referee_id] subscribeNext:^(id x) {
            NSLog(@"------ %@",x);
        } error:^(NSError *error) {
            NSLog(@"-------%@",error.localizedDescription);
        }];
        [self addDisposeSignal:disPos];
    }
}
// 发起砍价
- (void)startBargain
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service startBargain:self.activity_bargain_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self shareBargainWithUrl:x];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];

}
// 砍价分享
- (void)shareBargainWithUrl:(NSString *)bargainUrl
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.mineService fetchBargainShareInfo] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.loading = NO;
        // 分享
        NSString *shareTitle = [dict[@"title"] stringByReplacingOccurrencesOfString:@"{goods_title}" withString:self.productName];
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙砍价"
                                          title:shareTitle
                                    detailTitle:dict[@"description"]
                                          image:[NSURL URLWithString:self.thumb]
                                     htmlString:bargainUrl];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        // 分享
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙砍价"
                                          title:[NSString stringWithFormat:@"%@大砍价，人多力量大！",self.productName]
                                    detailTitle:@"砍价就要野蛮，动口不如动手！"
                                          image:[NSURL URLWithString:self.thumb]
                                     htmlString:bargainUrl];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -立即拼团
// 用户是否参与拼团
- (void)fetchGoodsJoinGroup
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service fetchGoodsJoinGroup:self.activity_group_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:@"你已参与此拼团，请耐心等待"];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self confirmOrder];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -确认下单
// 确认下单
- (void)confirmOrder
{
    ConfirmOrderViewModel *vm =
    [[ConfirmOrderViewModel alloc] initWithConfirm_order_from:ConfirmOrderFrom_GoodsDetail
                                                   goods_type:self.detailType
                                                goods_cart_id:nil
                                                     goods_id:self.productID
                                                 goods_sku_id:self.paramsRowViewModel.goods_sku_id
                                                     quantity:[NSString stringWithFormat:@"%ld",(long)self.paramsRowViewModel.quantity]
                                            activity_flash_id:self.activity_flash_id
                                            activity_group_id:self.activity_group_id
                                          activity_bargain_id:nil
                                              bargain_open_id:nil
                                                storehouse_id:self.storehouse_id
     reffer_id:self.referee_id];
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_GotoConfirmOrder;
    [self.updatedContentSignal sendNext:vm];
}

#pragma mark -获取评论列表vm
- (id)fetchCommentListVM
{
    if (!self.commentListVM) {
        self.commentListVM = [[CommentListViewModel alloc] initWithCommentType:CommentType_GoodsDetail
                                                                      goods_id:self.productID
                                                               order_detail_id:nil];
    }
    return self.commentListVM;
}

#pragma mark -获取商品介绍vm
- (id)fetchIntrodecuVM
{
    if (!self.introduceVM) {
        self.introduceVM = [[GoodsDetailIntroduceViewModel alloc] initWithGoods_id:self.productID];
    }
    return self.introduceVM;
}

#pragma mark -切换视图显示
- (void)changeNavViewToIndex:(NSInteger)index
{
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_ChangeNavViewIndex;
    [self.updatedContentSignal sendNext:@(index)];
}

#pragma mark -多媒体播放
// 停止播放
- (void)stopPlay
{
    // 停止播放音频
    [self.audioPlayer pause];
    self.audioPlayer = nil;
}
// 播放音频
- (void)playAudio
{
    NSURL * url  = [NSURL URLWithString:self.productAudioDescUrl];
    if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
        [self stopPlay];
    }else{
        self.audioPlayer = [[AVPlayer alloc] initWithURL:url];
        [self.audioPlayer play];
    }
}

// 播放视频
- (void)playVideo
{
    self.currentSignalType = GoodsDetailViewModel_Signal_Type_PlayVideo;
    [self.updatedContentSignal sendNext:self.productVideoDescUrl];
}

@end
