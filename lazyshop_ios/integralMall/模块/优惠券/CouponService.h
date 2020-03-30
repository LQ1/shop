//
//  CouponService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponService : NSObject

#pragma mark -获取我的优惠券
- (RACSignal *)getMyCouponWithCoupon_type:(NSString *)coupon_type
                                     page:(NSString *)page;

#pragma mark -获取商品可用优惠券
- (RACSignal *)getGoodsCouponWithGoods_cat_id:(NSString *)goods_cat_id;

#pragma mark -领取优惠券
- (RACSignal *)receiveCouponWithCoupon_id:(NSString *)coupon_id;

@end
