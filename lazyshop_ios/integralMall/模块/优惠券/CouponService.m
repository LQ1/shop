//
//  CouponService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponService.h"

#import "CouponClient.h"
#import "CouponModel.h"
#import "MyCouponPageModel.h"

@interface CouponService()

@property (nonatomic,strong)CouponClient *client;

@end

@implementation CouponService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [CouponClient new];
    }
    return self;
}

#pragma mark -获取我的优惠券
- (RACSignal *)getMyCouponWithCoupon_type:(NSString *)coupon_type
                                     page:(NSString *)page
{
    return [[self.client getMyCouponWithCoupon_type:coupon_type
                                               page:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        MyCouponPageModel *couponPageModel = [MyCouponPageModel modelFromJSONDictionary:dict[@"data"]];
        couponPageModel.coupon = [CouponModel modelsFromJSONArray:couponPageModel.coupon];
        return couponPageModel;
    }];
}

#pragma mark -获取商品可用优惠券
- (RACSignal *)getGoodsCouponWithGoods_cat_id:(NSString *)goods_cat_id
{
    return [[self.client getGoodsCouponWithGoods_cat_id:goods_cat_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [CouponModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无可领取优惠券");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -领取优惠券
- (RACSignal *)receiveCouponWithCoupon_id:(NSString *)coupon_id
{
    return [[self.client receiveCouponWithCoupon_id:coupon_id] map:^id(id value) {
        return @(YES);
    }];
}

@end
