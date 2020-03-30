//
//  MineViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineViewModel.h"

#import "LYItemUIBaseViewModel.h"
#import "MyOrdersViewModel.h"

#import "MineService.h"
#import "MyScoreService.h"

#import "MyCouponsViewModel.h"

@interface MineViewModel()

@property (nonatomic,assign)MineViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)MineService *service;
@property (nonatomic, strong) MyScoreService *myScoreService;

@end

@implementation MineViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
        self.myScoreService = [MyScoreService new];
        [self setData];
    }
    return self;
}

#pragma mark -数据设置
- (void)setData
{
    LYItemUIBaseViewModel *sectionVM1 = [LYItemUIBaseViewModel new];
    sectionVM1.childViewModels = @[@(MineViewCellType_MyOrders)];
    
    LYItemUIBaseViewModel *sectionVM5 = [LYItemUIBaseViewModel new];
    sectionVM5.childViewModels = @[@(MineViewCellType_Partner)];
    
    LYItemUIBaseViewModel *sectionVM2 = [LYItemUIBaseViewModel new];
    sectionVM2.childViewModels = @[@(MineViewCellType_MyGroupBuy),@(MineViewCellType_MyBargain)];

    LYItemUIBaseViewModel *sectionVM3 = [LYItemUIBaseViewModel new];
    sectionVM3.childViewModels = @[@(MineViewCellType_AddressManage),@(MineViewCellType_Setting)];
    
    LYItemUIBaseViewModel *sectionVM4 = [LYItemUIBaseViewModel new];
    sectionVM4.childViewModels = @[@(MineViewCellType_Connect),@(MineViewCellType_BuyTip),@(MineViewCellType_PostTip),@(MineViewCellType_AfterBuyTip)];

    self.dataArray = @[sectionVM1,sectionVM5,sectionVM2,sectionVM3,sectionVM4];
}

#pragma mark -获取基础显示信息
- (void)getBaseUserData
{
    if (![AccountService shareInstance].isLogin) {
        return;
    }
    @weakify(self);
    RACDisposable *disPos = [[self.service getUserMsg] subscribeNext:^(id x) {
        @strongify(self);
        self.currentSignalType = MineViewModel_Signal_Type_ReloadView;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        CLog(@"获取个人基础信息失败:%@",error);
    }];
    [self addDisposeSignal:disPos];
    
    // 获取会员等级
    RACDisposable *myScoreDisPos = [[self.myScoreService getUserGrowthDetail] subscribeNext:^(id x) {
        @strongify(self);
        self.currentSignalType = MineViewModel_Signal_Type_ReloadView;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        CLog(@"获取会员等级信息失败:%@",error);
    }];
    [self addDisposeSignal:myScoreDisPos];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:section];
    return secVM.childViewModels.count;
}

- (MineViewCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:indexPath.section];
    return [[secVM.childViewModels objectAtIndex:indexPath.row] integerValue];
}

- (CGFloat)getPartnerHeight {
    UIImage *image = SignInUser.partner.picImage;
    if (image != nil) {
        return (KScreenWidth-32)*image.size.height/image.size.width;
    }
    
    return 136;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([self cellTypeForRowAtIndexPath:indexPath]) {
        case MineViewCellType_MyGroupBuy:
        {
            // 拼团
            self.currentSignalType = MineViewModel_Signal_Type_GotoMyGroupBuy;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_MyBargain:
        {
            // 砍价
            self.currentSignalType = MineViewModel_Signal_Type_GotoMyBargain;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_AddressManage:
        {
            // 地址管理
            self.currentSignalType = MineViewModel_Signal_Type_GotoAddressManage;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_Setting:
        {
            // 设置
            self.currentSignalType = MineViewModel_Signal_Type_GotoSetting;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_Connect:
        {
            // 联系我们
            self.currentSignalType = MineViewModel_Signal_Type_GotoConnect;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_BuyTip:
        {
            // 购物须知
            self.currentSignalType = MineViewModel_Signal_Type_GotoBuyTip;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_PostTip:
        {
            // 配送说明
            self.currentSignalType = MineViewModel_Signal_Type_GotoPostTip;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MineViewCellType_AfterBuyTip:
        {
            // 售后说明
            self.currentSignalType = MineViewModel_Signal_Type_GotoAfterBuyTip;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -跳转
// 评价中心
- (void)gotoCommentCenter
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoCommentCenter;
    [self.updatedContentSignal sendNext:nil];
}
// 我的订单
- (void)gotoMyOrdersWithStatus:(OrderStatus)status
{
    MyOrdersViewModel *vm = [[MyOrdersViewModel alloc] initWithOrderStatus:status];
    self.currentSignalType = MineViewModel_Signal_Type_GotoMyOrders;
    [self.updatedContentSignal sendNext:vm];
}
// 我的积分
- (void)gotoMyScore
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoMyScore;
    [self.updatedContentSignal sendNext:nil];
}
// 积分签到
- (void)gotoScoreSignIn
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoScoreSignIn;
    [self.updatedContentSignal sendNext:nil];
}
// 关联店铺
- (void)gotoRelateStore
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoRelateStore;
    [self.updatedContentSignal sendNext:nil];
}
// 返利
- (void)gotoCashBack
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoCashBack;
    [self.updatedContentSignal sendNext:nil];

}
// 优惠券
- (void)gotoMyCoupons
{
    MyCouponsViewModel *vm = [[MyCouponsViewModel alloc] initWithInValidSelected:NO];
    self.currentSignalType = MineViewModel_Signal_Type_GotoMyCoupons;
    [self.updatedContentSignal sendNext:vm];

}
// 点击头部
- (void)headerClick
{
    self.currentSignalType = MineViewModel_Signal_Type_GotoPersonalMessage;
    [self.updatedContentSignal sendNext:nil];
}

@end
