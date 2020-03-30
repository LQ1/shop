//
//  GoodsDetailCouponChooseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCouponChooseViewModel.h"

#import "CouponItemViewModel.h"
#import "CouponService.h"
#import "CouponModel.h"

@interface GoodsDetailCouponChooseViewModel()

@property (nonatomic,copy ) NSString *goods_cat_id;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) CouponService *service;

@end

@implementation GoodsDetailCouponChooseViewModel

- (instancetype)initWithGoods_cat_id:(NSString *)goods_cat_id
{
    self = [super init];
    if (self) {
        self.goods_cat_id = goods_cat_id;
        self.service = [CouponService new];
    }
    return self;
}

#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getGoodsCouponWithGoods_cat_id:self.goods_cat_id] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(CouponModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *startTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_start_at]
                                                format:@"yyyy年MM月dd日"];
            NSString *endTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_end_at]
                                              format:@"yyyy年MM月dd日"];
            NSString *validTime = [NSString stringWithFormat:@"有效期:%@至%@",startTime,endTime];
            
            GoodsDetailCouponState couponState;
            if ([obj.coupon_status integerValue] == 0) {
                couponState = GoodsDetailCouponState_NoneToReceive;
            }else if ([obj.coupon_status integerValue] == 1){
                couponState = GoodsDetailCouponState_CanReceive;
            }else{
                couponState = GoodsDetailCouponState_Received;
            }
            
            CouponItemViewModel *itemVM = [[CouponItemViewModel alloc] initWithCouponID:obj.coupon_id user_coupon_id:obj.user_coupon_id moneyValue:obj.coupon_price tipMsg1:obj.coupon_title tipMsg2:obj.coupon_description validTime:validTime goods_cat_id:nil checkBoxStyle:NO couponState:couponState];
            [resultArray addObject:itemVM];
        }];
        self.dataArray = [NSArray arrayWithArray:resultArray];
        self.currentSignalType = GoodsDetailCouponChooseViewModel_Signal_Type_GetDataSuccess;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = GoodsDetailCouponChooseViewModel_Signal_Type_GetDataFail;
        [self.updatedContentSignal sendNext:nil];
    }];
    [self addDisposeSignal:disPos];
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

#pragma mark -领取优惠券
- (void)receiveCouponAtIndexPath:(NSIndexPath *)indexPath
{
    CouponItemViewModel *itemVM = [self itemViewModelAtIndexPath:indexPath];
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service receiveCouponWithCoupon_id:itemVM.couponID] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = GoodsDetailCouponChooseViewModel_Signal_Type_ReceiveSuccess;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = GoodsDetailCouponChooseViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];

}

@end
