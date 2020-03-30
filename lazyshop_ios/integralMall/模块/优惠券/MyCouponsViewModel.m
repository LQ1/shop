//
//  MyCouponsViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyCouponsViewModel.h"

#import "CouponItemViewModel.h"
#import "LYHeaderSwitchItemViewModel.h"

#import "CouponService.h"
#import "MyCouponPageModel.h"

#import "ProductListViewModel.h"

@interface MyCouponsViewModel()

@property (nonatomic,strong)NSArray *allDataArray;
@property (nonatomic,strong)CouponService *service;

@end

@implementation MyCouponsViewModel

- (instancetype)initWithInValidSelected:(BOOL)inValidSelected
{
    self = [super init];
    if (self) {
        self.inValidCouponDataSource = inValidSelected;
        self.service = [CouponService new];
        [self initHeaderDataSource];
    }
    return self;
}

#pragma mark -初始化头部数据源
- (void)initHeaderDataSource
{
    // 未使用
    LYHeaderSwitchItemViewModel *switchVM1 = [LYHeaderSwitchItemViewModel new];
    switchVM1.title = @"未使用";
    switchVM1.itemType = 0;
    switchVM1.selected = !self.inValidCouponDataSource;
    // 失效券
    LYHeaderSwitchItemViewModel *switchVM2 = [LYHeaderSwitchItemViewModel new];
    switchVM2.title = @"不可用";
    switchVM2.itemType = 1;
    switchVM2.selected = self.inValidCouponDataSource;

    self.switchItemViewModels = @[switchVM1,switchVM2];
}
// 刷新头图数据源
- (void)reloadHeaderDataSourceWith:(MyCouponPageModel *)pageModel
{
    LYHeaderSwitchItemViewModel *switchVM1 = [self.switchItemViewModels linq_where:^BOOL(LYHeaderSwitchItemViewModel *item) {
        return item.itemType == 0;
    }].linq_firstOrNil;
    NSString *validTitle = @"未使用";
    if ([pageModel.not_use_total integerValue]>0) {
        validTitle = [validTitle stringByAppendingString:[NSString stringWithFormat:@"(%@)",pageModel.not_use_total]];
    }
    switchVM1.title = validTitle;
    
    LYHeaderSwitchItemViewModel *switchVM2 = [self.switchItemViewModels linq_where:^BOOL(LYHeaderSwitchItemViewModel *item) {
        return item.itemType == 1;
    }].linq_firstOrNil;
    NSString *invalidTitle = @"不可用";
    if ([pageModel.available_total integerValue]>0) {
        invalidTitle = [invalidTitle stringByAppendingString:[NSString stringWithFormat:@"(%@)",pageModel.available_total]];
    }
    switchVM2.title = invalidTitle;
}

#pragma mark -获取优惠券列表
- (void)getData:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.dataArray.count];
    }
    @weakify(self);
    RACDisposable *disPos = [[self.service getMyCouponWithCoupon_type:self.inValidCouponDataSource?@"1":@"0" page:page] subscribeNext:^(MyCouponPageModel *pageModel) {
        @strongify(self);
        [self reloadHeaderDataSourceWith:pageModel];
        if (pageModel.coupon.count) {
            [self dealDataWithModel:pageModel refresh:refresh];
            self.currentSignalType = MyCouponsViewModel_Signal_Type_GetDataSuccess;
            [self.updatedContentSignal sendNext:self.dataArray];
        }else{
            self.currentSignalType = MyCouponsViewModel_Signal_Type_GetDataFailed;
            [self.updatedContentSignal sendNext:AppErrorEmptySetting(@"暂无此类优惠券")];
        }
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = MyCouponsViewModel_Signal_Type_GetDataFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithModel:(MyCouponPageModel *)pageModel
                  refresh:(BOOL)refresh
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [pageModel.coupon enumerateObjectsUsingBlock:^(CouponModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *startTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_start_at]
                                            format:@"yyyy年MM月dd日"];
        NSString *endTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_end_at]
                                            format:@"yyyy年MM月dd日"];
        NSString *validTime = [NSString stringWithFormat:@"有效期:%@至%@",startTime,endTime];

        GoodsDetailCouponState couponState;
        if ([obj.coupon_status integerValue] == 0) {
            couponState = GoodsDetailCouponState_CanBeUsed;
        }else if ([obj.coupon_status integerValue] == 1){
            couponState = GoodsDetailCouponState_Overdue;
        }else{
            couponState = GoodsDetailCouponState_Used;
        }
        CouponItemViewModel *itemVM = [[CouponItemViewModel alloc] initWithCouponID:obj.coupon_id
                                                                     user_coupon_id:obj.user_coupon_id
                                                                          moneyValue:obj.coupon_price
                                                                             tipMsg1:obj.coupon_title
                                                                             tipMsg2:obj.coupon_description
                                                                           validTime:validTime
                                                                        goods_cat_id:obj.goods_cat_id
                                                                       checkBoxStyle:NO
                                                                         couponState:couponState];
        [resultArray addObject:itemVM];
    }];
    if (refresh) {
        self.dataArray = [NSArray arrayWithArray:resultArray];
    }else{
        self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
    }
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CouponItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)useCouponAtIndexPath:(NSIndexPath *)indexPath
{
    CouponItemViewModel *itemVM = [self itemViewModelAtIndexPath:indexPath];
    ProductListViewModel *productVM = [[ProductListViewModel alloc] initWithCartType:@"0"
                                                                        goods_cat_id:itemVM.goods_cat_id
                                                                         goods_title:nil];
    self.currentSignalType = MyCouponsViewModel_Signal_Type_GotoProductList;
    [self.updatedContentSignal sendNext:productVM];
}

@end
