//
//  PaymentService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentService.h"

#import "PaymentClient.h"
#import "PaymentModel.h"

#import "WXPayModel.h"

@interface PaymentService()

@property (nonatomic,strong) PaymentClient *client;

@end

@implementation PaymentService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [PaymentClient new];
    }
    return self;
}

/*
 *  储值商品下单
 */
- (RACSignal *)createMoneyOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                 user_coupon_id:(NSString *)user_coupon_id
                                  goods_cart_id:(NSString *)goods_cart_id
                                        postage:(NSString *)postage
                                user_address_id:(NSString *)user_address_id
                                  storehouse_id:(NSString *)storehouse_id
                                reffer_id:(NSString*)reffer_id
{
    return [[self.client createMoneyOrderWithGoods_sku_id:goods_sku_id
                                          user_coupon_id:user_coupon_id
                                           goods_cart_id:goods_cart_id
                                                 postage:postage
                                          user_address_id:user_address_id
                                            storehouse_id:storehouse_id
                                            reffer_id:reffer_id] map:^id(NSDictionary *dict) {
        [[ShoppingCartService sharedInstance] getCartGoodsQuantity];
        return [PaymentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}
/*
 *  拼团商品下单
 */
- (RACSignal *)createGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id
{
    return [[self.client createGroupOrderWithActivity_group_id:activity_group_id
                                                      quantity:quantity
                                               user_address_id:user_address_id
                                                 storehouse_id:storehouse_id] map:^id(NSDictionary *dict) {
        return [PaymentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}
/*
 *  秒杀商品下单
 */
- (RACSignal *)createFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id
{
    return [[self.client createFlashOrderWithActivity_flash_id:activity_flash_id
                                                      quantity:quantity
                                               user_address_id:user_address_id
                                                 storehouse_id:storehouse_id] map:^id(NSDictionary *dict) {
        return [PaymentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}
/*
 *  积分商品下单
 */
- (RACSignal *)createScoreOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                       quantity:(NSString *)quantity
                                user_address_id:(NSString *)user_address_id
                                        postage:(NSString *)postage
                                  storehouse_id:(NSString *)storehouse_id
{
    return [[self.client createScoreOrderWithGoods_sku_id:goods_sku_id
                                                 quantity:quantity
                                          user_address_id:user_address_id
                                                  postage:postage
                                            storehouse_id:storehouse_id] map:^id(NSDictionary *dict) {
        return [PaymentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

/*
 *  砍价商品下单
 */
- (RACSignal *)createBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                         bargain_open_id:(NSString *)bargain_open_id
                                                quantity:(NSString *)quantity
                                         user_address_id:(NSString *)user_address_id
                                           storehouse_id:(NSString *)storehouse_id
{
    return [[self.client createBargainOrderWithActivity_bargain_id:activity_bargain_id
                                                  bargain_open_id:bargain_open_id
                                                         quantity:quantity
                                                  user_address_id:user_address_id
                                                    storehouse_id:storehouse_id] map:^id(NSDictionary *dict) {
        return [PaymentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

/*
 *  获取支付宝签名
 */
- (RACSignal *)fetchAliPayOrderStringWithOrderID:(NSString *)orderID
{
    return [[self.client fetchAliPayOrderStringWithOrderID:orderID] map:^id(NSDictionary *dict) {
        return dict[@"data"][@"order_string"];
    }];
}
/*
 *  获取微信支付签名
 */
- (RACSignal *)fetchWXPayOrderStringWithOrderID:(NSString *)orderID
{
    return [[self.client fetchWXPayOrderStringWithOrderID:orderID] map:^id(NSDictionary *dict) {
        return [WXPayModel modelFromJSONDictionary:dict[@"data"]];
    }];
}
/*
 *  获取银联支付签名
 */
- (RACSignal *)fetchUnionPayOrderStringWithOrderID:(NSString *)orderID
{
    return [[self.client fetchUnionPayOrderStringWithOrderID:orderID] map:^id(NSDictionary *dict) {
        return dict[@"data"][@"tn"];
    }];
}

#pragma mark -到店支付
- (RACSignal *)shopPayWithOrderID:(NSString *)orderID
{
    return [[self.client shopPayWithOrderID:orderID] map:^id(NSDictionary *dict) {
        return dict[@"data"][@"msg"];
    }];
}

@end
