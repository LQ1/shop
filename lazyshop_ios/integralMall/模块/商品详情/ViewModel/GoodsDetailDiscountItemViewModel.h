//
//  GoodsDetailDiscountItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

typedef NS_ENUM(NSInteger, GoodsDetailDiscountType)
{
    // 优惠券
    GoodsDetailDiscountType_Coupon = 0,
    // 积分
    GoodsDetailDiscountType_Integral,
    // 返现
    GoodsDetailDiscountType_CashBack
};

@interface GoodsDetailDiscountItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign)GoodsDetailDiscountType discountType;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *detail;

- (instancetype)initWithGoodsDetailDiscountType:(GoodsDetailDiscountType)discountType
                                         detail:(NSString *)detail;

@end
