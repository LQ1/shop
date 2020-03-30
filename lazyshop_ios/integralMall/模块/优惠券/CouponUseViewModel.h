//
//  CouponUseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CouponItemViewModel;

typedef NS_ENUM(NSInteger, CouponUseViewModel_Signal_Type)
{
    CouponUseViewModel_Signal_Type_TipLoading = 0,
    CouponUseViewModel_Signal_Type_GetDataSuccess,
    CouponUseViewModel_Signal_Type_GetDataFailed,
    CouponUseViewModel_Signal_Type_ReloadData,
    CouponUseViewModel_Signal_Type_UseCouponSuccess
};

@interface CouponUseViewModel : BaseViewModel

@property (nonatomic,readonly)CouponUseViewModel_Signal_Type currentSignalType;

- (instancetype)initWithCouponItenViewModels:(NSArray *)coupons
                            selectedCouponID:(NSString *)selectedCouponID;

- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CouponItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)useSelectCoupon;

@end
