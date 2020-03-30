//
//  GoodsDetailCouponItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponItemViewModel.h"

#import "CouponItemCell.h"

@implementation CouponItemViewModel

- (instancetype)initWithCouponID:(NSString *)couponID
                  user_coupon_id:(NSString *)user_coupon_id
                      moneyValue:(NSString *)moneyValue
                         tipMsg1:(NSString *)tipMsg1
                         tipMsg2:(NSString *)tipMsg2
                       validTime:(NSString *)validTime
                    goods_cat_id:(NSString *)goods_cat_id
                   checkBoxStyle:(BOOL)checkBoxStyle
                     couponState:(GoodsDetailCouponState)state
{
    self = [super init];
    if (self) {
        self.couponID = couponID;
        self.user_coupon_id = user_coupon_id;
        self.moneyValue = moneyValue;
        self.tipMsg1 = tipMsg1;
        self.tipMsg2 = tipMsg2;
        self.validTime = validTime;
        self.goods_cat_id = goods_cat_id;

        self.checkBoxStyle = checkBoxStyle;
        self.couponState = state;
        
        self.UIClassName = NSStringFromClass([CouponItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 110.f;
    }
    return self;
}


@end
