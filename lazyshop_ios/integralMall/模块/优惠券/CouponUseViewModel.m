//
//  CouponUseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponUseViewModel.h"

#import "CouponItemViewModel.h"

@interface CouponUseViewModel()

@property (nonatomic,assign)CouponUseViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation CouponUseViewModel

- (instancetype)initWithCouponItenViewModels:(NSArray *)coupons
                            selectedCouponID:(NSString *)selectedCouponID
{
    self = [super init];
    if (self) {
        [coupons enumerateObjectsUsingBlock:^(CouponItemViewModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.couponID isEqualToString:selectedCouponID]) {
                obj.selected = YES;
            }else{
                obj.selected = NO;
            }
        }];
        self.dataArray = [NSArray arrayWithArray:coupons];
    }
    return self;
}

- (void)getData
{
    self.currentSignalType = CouponUseViewModel_Signal_Type_GetDataSuccess;
    [self.updatedContentSignal sendNext:nil];
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

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(CouponItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            // 反置优惠券状态
            itemVM.selected = !itemVM.selected;
        }else{
            itemVM.selected = NO;
        }
    }];
    
    self.currentSignalType = CouponUseViewModel_Signal_Type_ReloadData;
    [self.updatedContentSignal sendNext:nil];
}

- (void)useSelectCoupon
{
    CouponItemViewModel *selectedVM = [self.dataArray linq_where:^BOOL(CouponItemViewModel *item) {
        return item.selected == YES;
    }].linq_firstOrNil;
    self.currentSignalType = CouponUseViewModel_Signal_Type_UseCouponSuccess;
    [self.updatedContentSignal sendNext:RACTuplePack(selectedVM.user_coupon_id,selectedVM.moneyValue)];
}

@end
