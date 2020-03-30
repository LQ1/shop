//
//  HomeViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeViewModel.h"

#import "HomeService.h"
#import "HomeContentModel.h"

#import "HomeCycleScrollCellViewModel.h"
#import "HomeCycleItemModel.h"
#import "HomeCategoryCellViewModel.h"
#import "HomeCategoryItemModel.h"
#import "HomeScoreCellViewModel.h"
#import "HomeScoreScrollItemModel.h"
#import "HomeLeisureCellViewModel.h"
#import "HomeAllActivityCellViewModel.h"
#import "HomeSecKillCellViewModel.h"
#import "HomeGroupByCellViewModel.h"
#import "HomeBargainCellViewModel.h"
#import "HomeSelectedCellViewModel.h"
#import "HomeRecommendCellViewModel.h"
#import "HomeChosenCellViewModel.h"
#import "JoinPartnerCellViewModel.h"

#import "ProductListItemViewModel.h"
#import "ProductListItemModel.h"

#import "SecKillCountDownManager.h"

@interface HomeViewModel ()

@property (nonatomic,assign)HomeViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)HomeService *service;

@property (nonatomic,strong)HomeChosenCellViewModel *chosenViewModel;

@end

@implementation HomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [HomeService new];
        [[SecKillCountDownManager sharedInstance] refetchNetTimes];
    }
    return self;
}

#pragma mark -获取数据
- (void)getData
{
    @weakify(self);
    // 获取活动
    RACDisposable *activitysDisPos = [[self.service fetchHomeActivitys] subscribeNext:^(id x) {
        @strongify(self);
        [self dealActivityDataWith:x];
        //[self getGoodsListRefresh:YES];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = HomeViewModel_GetDataFail;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:activitysDisPos];
}

// 处理活动数据
- (void)dealActivityDataWith:(HomeContentModel *)contentModel
{
    NSMutableArray *resultArray = [NSMutableArray array];
    // 轮询图
    if (contentModel.banner.count) {
        HomeCycleScrollCellViewModel *cellVM1 = [[HomeCycleScrollCellViewModel alloc] initWithItemModels:contentModel.banner];
        [resultArray addObject:cellVM1];
    }
    
    // 分类
    if (contentModel.navcat.count) {
        HomeCategoryCellViewModel *cellVM2 = [[HomeCategoryCellViewModel alloc] initWithItemModels:contentModel.navcat];
        
        [resultArray addObject:cellVM2];
    }
    
    //合伙人
    if (contentModel.partner) {
        JoinPartnerCellViewModel *cellJoinPartner = [[JoinPartnerCellViewModel alloc] initWithItemModels:contentModel.partner];
        
        [resultArray addObject:cellJoinPartner];
    }
    
    // 积分商城
    if (contentModel.integralCat.count) {
        HomeScoreCellViewModel *scoreVM = [[HomeScoreCellViewModel alloc] initWithItemModels:contentModel.integralCat
                                                                           scoreSingleImgUrl:contentModel.integralThumb];
        [resultArray addObject:scoreVM];
    }
    
    // 休闲娱乐
    if (contentModel.leisure.count) {
        HomeLeisureCellViewModel *leisureVM = [[HomeLeisureCellViewModel alloc] initWithItemModels:contentModel.leisure];
        [resultArray addObject:leisureVM];
    }
    
    NSMutableArray *allActivityVMs = [NSMutableArray array];
    // 秒杀
    if (contentModel.flash.count) {
        HomeSecKillCellViewModel *secKillVM = [[HomeSecKillCellViewModel alloc] initWithItemModels:contentModel.flash];
        secKillVM.slogan = contentModel.flash_slogan;
        [allActivityVMs addObject:secKillVM];
    }
    // 拼团
    if (contentModel.group.count) {
        HomeGroupByCellViewModel *groupBuyVM = [[HomeGroupByCellViewModel alloc] initWithItemModels:contentModel.group];
        groupBuyVM.slogan = contentModel.group_slogan;
        [allActivityVMs addObject:groupBuyVM];
    }
    // 砍价
    if (contentModel.bargain.count) {
        HomeBargainCellViewModel *bargainVM = [[HomeBargainCellViewModel alloc] initWithItemModels:contentModel.bargain];
        bargainVM.slogan = contentModel.bargain_slogan;
        [allActivityVMs addObject:bargainVM];
    }
    if (allActivityVMs.count) {
        HomeAllActivityCellViewModel *allActivityVM = [[HomeAllActivityCellViewModel alloc] initWithActivityCellVMS:allActivityVMs];
        [resultArray addObject:allActivityVM];
    }
    
    // 懒店精选
    if (contentModel.selected.count) {
        HomeSelectedCellViewModel *homeSelectedVM = [[HomeSelectedCellViewModel alloc] initSelectedModels:contentModel.selected recomModel:contentModel.brandRecommend];
        [resultArray addObject:homeSelectedVM];
    }
    
    // 懒店推荐
    if (contentModel.foot_banner.count) {
        HomeRecommendCellViewModel *recomCellVM = [[HomeRecommendCellViewModel alloc] initWithItemModels:contentModel.foot_banner];
        [resultArray addObject:recomCellVM];
    }
    
    self.dataArray = [NSArray arrayWithArray:resultArray];
    self.currentSignalType = HomeViewModel_GetDataSuccess;
    [self.updatedContentSignal sendNext:nil];
}
// 获取商品列表
- (void)getGoodsListRefresh:(BOOL)refresh
{
    if (refresh) {
        self.oldDataCount = 0;
    }
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:[self.chosenViewModel itemCountAtSection:0]];
    }
    // 获取商品列表
    @weakify(self);
    RACDisposable *productListDisPos = [[self.service fetchHomeGoodsListWithPage:page] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(ProductListItemModel *productListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductListItemViewModel *itemVM = [[ProductListItemViewModel alloc] initWithModel:productListModel];
            [resultArray addObject:itemVM];
        }];
        if (refresh) {
            self.chosenViewModel = [[HomeChosenCellViewModel alloc] initWithItemModels:resultArray];
        }else{
            self.chosenViewModel.itemModels = [self.chosenViewModel.itemModels arrayByAddingObjectsFromArray:resultArray];
        }
        if (refresh) {
            self.dataArray = [self.dataArray arrayByAddingObject:self.chosenViewModel];
        }else{
            [self.chosenViewModel resetCellHeight];
        }
        self.currentSignalType = HomeViewModel_GetProductsSuccess;
        [self.updatedContentSignal sendNext:self.chosenViewModel.itemModels];

    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = HomeViewModel_GetProductsFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:productListDisPos];
}

#pragma mark -列表相关
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

#pragma mark -跳转
// 秒杀列表
- (void)gotoSecKillList
{
    self.currentSignalType = HomeViewModel_GotoSecKillList;
    [self.updatedContentSignal sendNext:nil];
}
// 拼团列表
- (void)gotoGroupBuyList
{
    self.currentSignalType = HomeViewModel_GotoGroupBuyList;
    [self.updatedContentSignal sendNext:nil];
}
// 砍价列表
- (void)gotoBargainList
{
    self.currentSignalType = HomeViewModel_GotoBargainList;
    [self.updatedContentSignal sendNext:nil];
}
// 商品详情
- (void)gotoGoodsDetailWithVM:(id)vm
{
    self.currentSignalType = HomeViewModel_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:vm];
}
// 商品列表
- (void)gotoProductListWithVM:(id)vm
{
    self.currentSignalType = HomeViewModel_GotoProductList;
    [self.updatedContentSignal sendNext:vm];
}
// 积分商品
- (void)gotoScoreGoods
{
    self.currentSignalType = HomeViewModel_GotoScoreGoods;
    [self.updatedContentSignal sendNext:nil];
}
// 加入合伙人
- (void)gotoJoinParnter
{
    self.currentSignalType = HomeViewModel_GotoJoinPartner;
    [self.updatedContentSignal sendNext:nil];
}


@end
