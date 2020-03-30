//
//  GoodsDetailCouponChooseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CouponItemViewModel;

typedef NS_ENUM(NSInteger,GoodsDetailCouponChooseViewModel_Signal_Type) {
    GoodsDetailCouponChooseViewModel_Signal_Type_GetDataSuccess = 0,
    GoodsDetailCouponChooseViewModel_Signal_Type_GetDataFail,
    GoodsDetailCouponChooseViewModel_Signal_Type_TipLoading,
    GoodsDetailCouponChooseViewModel_Signal_Type_ReceiveSuccess
};

@interface GoodsDetailCouponChooseViewModel : BaseViewModel

@property (nonatomic,assign) GoodsDetailCouponChooseViewModel_Signal_Type currentSignalType;

- (instancetype)initWithGoods_cat_id:(NSString *)goods_cat_id;

- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CouponItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)receiveCouponAtIndexPath:(NSIndexPath *)indexPath;

@end
