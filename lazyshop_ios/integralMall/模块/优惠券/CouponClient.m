//
//  CouponClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponClient.h"

#define API_MY_COUPON_LIST    @"http://"APP_DOMAIN@"/user/couponlist"
#define API_GOODS_COUPON_LIST @"http://"APP_DOMAIN@"/coupon/list"
#define API_GET_COUPON        @"http://"APP_DOMAIN@"/coupon/get"

@implementation CouponClient

#pragma mark -获取我的优惠券
- (RACSignal *)getMyCouponWithCoupon_type:(NSString *)coupon_type
                                     page:(NSString *)page
{
    page = page?:@"";
    coupon_type = coupon_type?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"coupon_type":coupon_type,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_MY_COUPON_LIST params:prams dealCode:YES];
}

#pragma mark -获取商品可用优惠券
- (RACSignal *)getGoodsCouponWithGoods_cat_id:(NSString *)goods_cat_id
{
    goods_cat_id = goods_cat_id?:@"";
    
    NSDictionary *prams = @{
                            @"goods_cat_id":goods_cat_id,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GOODS_COUPON_LIST params:prams dealCode:YES];
}

#pragma mark -领取优惠券
- (RACSignal *)receiveCouponWithCoupon_id:(NSString *)coupon_id
{
    coupon_id = coupon_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"coupon_id":coupon_id
                            };
    
    return [LYHttpHelper POST:API_GET_COUPON params:prams dealCode:YES];
}


@end
