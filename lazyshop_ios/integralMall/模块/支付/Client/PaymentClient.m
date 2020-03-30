//
//  PaymentClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentClient.h"

#define API_CREATE_ORDER_MONEY @"http://"APP_DOMAIN@"/order/createmoneyorder"
#define API_CREATE_ORDER_GROUP @"http://"APP_DOMAIN@"/order/creategrouporder"
#define API_CREATE_ORDER_FLASH @"http://"APP_DOMAIN@"/order/createflashorder"
#define API_CREATE_ORDER_SCORE @"http://"APP_DOMAIN@"/order/createscoreorder"
#define API_CREATE_ORDER_BARGAIN @"http://"APP_DOMAIN@"/order/createbargainorder"

#define API_GET_ALIPAY_SIGN      @"http://"APP_DOMAIN@"/pay/alipay/orderstring"
#define API_GET_WXPAY_SIGN       @"http://"APP_DOMAIN@"/pay/wxpay/orderstring"
#define API_GET_UNIONPAY_SIGN    @"http://"APP_DOMAIN@"/pay/unionpay/orderstring"

// 到店支付
#define API_SHOP_PAY    @"http://"APP_DOMAIN@"/pay/shoppay"

@implementation PaymentClient

#pragma mark -储值商品下单
- (RACSignal *)createMoneyOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                 user_coupon_id:(NSString *)user_coupon_id
                                  goods_cart_id:(NSString *)goods_cart_id
                                        postage:(NSString *)postage
                                user_address_id:(NSString *)user_address_id
                                  storehouse_id:(NSString *)storehouse_id
                                      reffer_id:(NSString*)reffer_id
{
    goods_sku_id = goods_sku_id?:@"";
    user_coupon_id = user_coupon_id?:@"";
    goods_cart_id = goods_cart_id?:@"";
    postage = postage?:@"";
    user_address_id = user_address_id?:@"";
    storehouse_id = storehouse_id?:@"";
    reffer_id = reffer_id?:@"";
    
    NSDictionary *prams = @{
                            @"user_address_id":user_address_id,
                            @"token":SignInToken,
                            @"goods_sku_id":goods_sku_id,
                            @"user_coupon_id":user_coupon_id,
                            @"goods_cart_id":goods_cart_id,
                            @"postage":postage,
                            @"storehouse_id":storehouse_id,
                            @"reffer_id":reffer_id
                            };
    
    NSLog(@"%@",prams);
    
    return [LYHttpHelper POST:API_CREATE_ORDER_MONEY params:prams dealCode:YES];
}

#pragma mark -拼团商品下单
- (RACSignal *)createGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id
{
    activity_group_id = activity_group_id?:@"";
    quantity = quantity?:@"";
    storehouse_id = storehouse_id?:@"";
    
    NSDictionary *prams = @{
                            @"user_address_id":user_address_id,
                            @"token":SignInToken,
                            @"activity_group_id":activity_group_id,
                            @"quantity":quantity,
                            @"storehouse_id":storehouse_id
                            };
    
    return [LYHttpHelper POST:API_CREATE_ORDER_GROUP params:prams dealCode:YES];
}

#pragma mark -秒杀商品下单
- (RACSignal *)createFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id
{
    activity_flash_id = activity_flash_id?:@"";
    quantity = quantity?:@"";
    storehouse_id = storehouse_id?:@"";
    
    NSDictionary *prams = @{
                            @"user_address_id":user_address_id,
                            @"token":SignInToken,
                            @"activity_flash_id":activity_flash_id,
                            @"quantity":quantity,
                            @"storehouse_id":storehouse_id
                            };
    
    return [LYHttpHelper POST:API_CREATE_ORDER_FLASH params:prams dealCode:YES];
}

#pragma mark -积分商品下单
- (RACSignal *)createScoreOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                       quantity:(NSString *)quantity
                                user_address_id:(NSString *)user_address_id
                                        postage:(NSString *)postage
                                  storehouse_id:(NSString *)storehouse_id
{
    goods_sku_id = goods_sku_id?:@"";
    quantity = quantity?:@"";
    user_address_id = user_address_id?:@"";
    postage = postage?:@"";
    storehouse_id = storehouse_id?:@"";

    NSDictionary *prams = @{
                            @"user_address_id":user_address_id,
                            @"token":SignInToken,
                            @"goods_sku_id":goods_sku_id,
                            @"quantity":quantity,
                            @"storehouse_id":storehouse_id
                            };
    
    return [LYHttpHelper POST:API_CREATE_ORDER_SCORE params:prams dealCode:YES];
}

#pragma mark -砍价商品下单
- (RACSignal *)createBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                         bargain_open_id:(NSString *)bargain_open_id
                                                quantity:(NSString *)quantity
                                         user_address_id:(NSString *)user_address_id
                                           storehouse_id:(NSString *)storehouse_id
{
    activity_bargain_id = activity_bargain_id?:@"";
    bargain_open_id = bargain_open_id?:@"";
    quantity = quantity?:@"";
    user_address_id = user_address_id?:@"";
    storehouse_id = storehouse_id?:@"";
    
    NSDictionary *prams = @{
                            @"user_address_id":user_address_id,
                            @"token":SignInToken,
                            @"activity_bargain_id":activity_bargain_id,
                            @"bargain_open_id":bargain_open_id,
                            @"quantity":quantity,
                            @"storehouse_id":storehouse_id
                            };
    
    return [LYHttpHelper POST:API_CREATE_ORDER_BARGAIN params:prams dealCode:YES];
}

#pragma mark -获取支付宝签名
- (RACSignal *)fetchAliPayOrderStringWithOrderID:(NSString *)orderID
{
    orderID = orderID?:@"";
    
    NSDictionary *prams = @{
                            @"order_id":orderID,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_ALIPAY_SIGN params:prams dealCode:YES];
}

#pragma mark -获取微信支付签名
- (RACSignal *)fetchWXPayOrderStringWithOrderID:(NSString *)orderID
{
    orderID = orderID?:@"";
    
    NSDictionary *prams = @{
                            @"order_id":orderID,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_WXPAY_SIGN params:prams dealCode:YES];
}

#pragma mark -获取银联支付签名
- (RACSignal *)fetchUnionPayOrderStringWithOrderID:(NSString *)orderID
{
    orderID = orderID?:@"";
    
    NSDictionary *prams = @{
                            @"order_id":orderID,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_UNIONPAY_SIGN params:prams dealCode:YES];
}

#pragma mark -到店支付
- (RACSignal *)shopPayWithOrderID:(NSString *)orderID
{
    orderID = orderID?:@"";
    
    NSDictionary *prams = @{
                            @"order_id":orderID,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_SHOP_PAY params:prams dealCode:YES];
}

@end
