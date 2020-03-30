//
//  ConfrimOrderService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfrimOrderService.h"

#import "ConfirmOrderClient.h"

#import "ConfirmOrderModel.h"

@interface ConfrimOrderService()

@property (nonatomic,strong) ConfirmOrderClient *client;

@end

@implementation ConfrimOrderService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [ConfirmOrderClient new];
    }
    return self;
}

#pragma mark -储值商品确认下单
- (RACSignal *)confirmOrderWithConfirm_order_from:(NSString *)confirm_order_from
                                    goods_cart_id:(NSString *)goods_cart_id
                                         goods_id:(NSString *)goods_id
                                     goods_sku_id:(NSString *)goods_sku_id
                                         quantity:(NSString *)quantity
{
    return [[self.client confirmOrderWithConfirm_order_from:confirm_order_from
                                             goods_cart_id:goods_cart_id
                                                  goods_id:goods_id
                                              goods_sku_id:goods_sku_id
                                                  quantity:quantity] map:^id(NSDictionary *dict) {
        ConfirmOrderModel *model = [ConfirmOrderModel modelFromJSONDictionary:dict[@"data"]];
        model.coupon = [ConfrimOrderCouponModel modelFromJSONDictionary:(NSDictionary *)model.coupon];
        model.coupon.coupon_list = [CouponModel modelsFromJSONArray:model.coupon.coupon_list];
        model.user_address = [ShippingAddressModel modelFromJSONDictionary:(NSDictionary *)model.user_address];
        model.user_address.full_address = dict[@"data"][@"user_address"][@"address"];
        model.goods = [ConfirmOrderGoodsDetailModel modelsFromJSONArray:model.goods];
        return model;
    }];
}

#pragma mark -拼团商品确认下单
- (RACSignal *)confirmGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                             quantity:(NSString *)quantity
{
    return [[self.client confirmGroupOrderWithActivity_group_id:activity_group_id
                                                      quantity:quantity] map:^id(NSDictionary *dict) {
        ConfirmOrderModel *model = [ConfirmOrderModel modelFromJSONDictionary:dict[@"data"]];
        model.coupon = [ConfrimOrderCouponModel modelFromJSONDictionary:(NSDictionary *)model.coupon];
        model.coupon.coupon_list = [CouponModel modelsFromJSONArray:model.coupon.coupon_list];
        model.user_address = [ShippingAddressModel modelFromJSONDictionary:(NSDictionary *)model.user_address];
        model.user_address.full_address = dict[@"data"][@"user_address"][@"address"];
        model.goods = [ConfirmOrderGoodsDetailModel modelsFromJSONArray:model.goods];
        return model;
    }];
}

#pragma mark -秒杀商品确认下单
- (RACSignal *)confirmFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                             quantity:(NSString *)quantity
{
    return [[self.client confirmFlashOrderWithActivity_flash_id:activity_flash_id
                                                      quantity:quantity] map:^id(NSDictionary *dict) {
        ConfirmOrderModel *model = [ConfirmOrderModel modelFromJSONDictionary:dict[@"data"]];
        model.coupon = [ConfrimOrderCouponModel modelFromJSONDictionary:(NSDictionary *)model.coupon];
        model.coupon.coupon_list = [CouponModel modelsFromJSONArray:model.coupon.coupon_list];
        model.user_address = [ShippingAddressModel modelFromJSONDictionary:(NSDictionary *)model.user_address];
        model.user_address.full_address = dict[@"data"][@"user_address"][@"address"];
        model.goods = [ConfirmOrderGoodsDetailModel modelsFromJSONArray:model.goods];
        return model;
    }];
}

#pragma mark -积分商品确认下单
- (RACSignal *)confirmScoreOrderWithGoods_id:(NSString *)goods_id
                                goods_sku_id:(NSString *)goods_sku_id
                                    quantity:(NSString *)quantity
{
    return [[self.client confirmScoreOrderWithGoods_id:goods_id
                                         goods_sku_id:goods_sku_id
                                             quantity:quantity] map:^id(NSDictionary *dict) {
        ConfirmOrderModel *model = [ConfirmOrderModel modelFromJSONDictionary:dict[@"data"]];
        model.user_address = [ShippingAddressModel modelFromJSONDictionary:(NSDictionary *)model.user_address];
        model.user_address.full_address = dict[@"data"][@"user_address"][@"address"];
        model.goods = [ConfirmOrderGoodsDetailModel modelsFromJSONArray:model.goods];
        return model;
    }];
}

#pragma mark -砍价商品确认下单
- (RACSignal *)confirmBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                          bargain_open_id:(NSString *)bargain_open_id
{
    return [[self.client confirmBargainOrderWithActivity_bargain_id:activity_bargain_id
                                                   bargain_open_id:bargain_open_id] map:^id(NSDictionary *dict) {
        ConfirmOrderModel *model = [ConfirmOrderModel modelFromJSONDictionary:dict[@"data"]];
        model.user_address = [ShippingAddressModel modelFromJSONDictionary:(NSDictionary *)model.user_address];
        model.user_address.full_address = dict[@"data"][@"user_address"][@"address"];
        model.goods = [ConfirmOrderGoodsDetailModel modelsFromJSONArray:model.goods];
        return model;
    }];
}

@end
