//
//  SecKillListChangeItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListPageViewModel.h"

#import "SecKillTimePointModel.h"

#import "SecKillListItemCellViewModel.h"
#import "GoodsDetailViewModel.h"
#import "HomeService.h"
#import "ProductRowBaseModel.h"

#import "SecKillCountDownManager.h"

@interface SecKillListPageViewModel ()

@property (nonatomic,assign)SecKillListPageViewModel_Signal_Type currentSignalType;
@property (nonatomic,strong)HomeService *service;

@end

@implementation SecKillListPageViewModel

- (instancetype)initWithModel:(SecKillTimePointModel *)pointModel
                     allTimes:(NSArray *)allTimes
                  currentTime:(NSString *)currentTime
{
    self = [super init];
    if (self) {
        self.service = [HomeService new];
        
        self.startTime = pointModel.time;
        // 状态
        NSDate *currentTimeDate = [CommUtls dencodeTime:currentTime];
        NSDate *startTimeDate = [CommUtls dencodeTime:pointModel.sell_start_at];
        NSDate *endTimeDate = [CommUtls dencodeTime:pointModel.sell_end_at];
        if ([currentTimeDate timeIntervalSinceDate:startTimeDate]<0) {
            // 即将开始
            self.state = SecKillListState_WillBegin;
        }else if ([currentTimeDate timeIntervalSinceDate:startTimeDate]>=0&&[currentTimeDate timeIntervalSinceDate:endTimeDate]<0){
            // 进行中
            self.state = SecKillListState_Begining;
        }else{
            // 已结束
            self.state = SecKillListState_IsEnd;
        }
        // 当前是否选中
        if (self.state == SecKillListState_Begining) {
            self.selected = YES;
        }
        // 秒杀剩余时间
        if (self.state == SecKillListState_Begining) {
            @weakify(self);
            [[[RACObserve([SecKillCountDownManager sharedInstance], validSeconds) takeUntil:self.rac_willDeallocSignal] distinctUntilChanged] subscribeNext:^(id x) {
                @strongify(self);
                self.validSeconds = [x integerValue];
            }];
        }
    }
    return self;
}

#pragma mark -基础数据
- (NSString *)stringValidTime
{
    NSInteger hour = self.validSeconds/60/60;
    NSInteger minite = (self.validSeconds/60)%60;
    NSInteger second = self.validSeconds%60;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minite,(long)second];
}

#pragma mark -获取数据
- (void)getDataRefresh:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.childViewModels.count];
    }
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchSecKillListWithPage:page sell_start_at:self.startTime] subscribeNext:^(NSArray *prudctBaseModels) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [prudctBaseModels enumerateObjectsUsingBlock:^(ProductRowBaseModel *baseModel, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            SecKillListItemCellViewModel *itemCellVM = [SecKillListItemCellViewModel new];
            itemCellVM.productID = baseModel.goods_id;
            itemCellVM.productImageUrl = baseModel.thumb;
            itemCellVM.productPrice = baseModel.price;
            itemCellVM.slogan = baseModel.slogan;
            itemCellVM.productName = baseModel.title;
            itemCellVM.remainNumber = [baseModel.stock integerValue];
            itemCellVM.activity_flash_id = [baseModel.activity_flash_id lyStringValue];
            if (self.state == SecKillListState_IsEnd) {
                itemCellVM.isEnd = YES;
            }else{
                itemCellVM.isEnd = NO;
            }
            [resultArray addObject:itemCellVM];
        }];
        if (refresh) {
            self.childViewModels = [NSArray arrayWithArray:resultArray];
        }else{
            self.childViewModels = [self.childViewModels arrayByAddingObjectsFromArray:resultArray];
        }
        self.currentSignalType = SecKillListPageViewModel_Signal_Type_FetchListSuccess;
        [self.updatedContentSignal sendNext:self.childViewModels];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = SecKillListPageViewModel_Signal_Type_FetchListFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -列表展示相关
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.childViewModels.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.childViewModels objectAtIndex:indexPath.row];
}

- (void)gotoGoodsDetailAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.state == SecKillListState_IsEnd) {
        self.currentSignalType = SecKillListPageViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:@"秒杀活动已结束,请下次再来吧"];
        return;
    }
    // 进入商品详情
    SecKillListItemCellViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    GoodsDetailViewModel *goodDetailVM = [[GoodsDetailViewModel alloc] initWithProductID:itemVM.productID
                                                                         goodsDetailType:GoodsDetailType_SecKill
                                                                       activity_flash_id:itemVM.activity_flash_id
                                                                     activity_bargain_id:nil
                                                                       activity_group_id:nil];
    self.currentSignalType = SecKillListPageViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:goodDetailVM];
}

@end
