//
//  ConfirmOrderClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderClient.h"

#define API_CONFIRM_ORDER_NORMAL    @"http://"APP_DOMAIN@"/order/confirmmoneyorder"
#define API_CONFIRM_ORDER_GROUP     @"http://"APP_DOMAIN@"/order/confirmgrouporder"
#define API_CONFIRM_ORDER_FLASH     @"http://"APP_DOMAIN@"/order/confirmflashorder"
#define API_CONFIRM_ORDER_STORE     @"http://"APP_DOMAIN@"/order/confirmscoreorder"
#define API_CONFIRM_ORDER_BARGAIN   @"http://"APP_DOMAIN@"/order/confirmbargainorder"


@implementation ConfirmOrderClient

#pragma mark -储值商品确认下单
- (RACSignal *)confirmOrderWithConfirm_order_from:(NSString *)confirm_order_from
                                    goods_cart_id:(NSString *)goods_cart_id
                                         goods_id:(NSString *)goods_id
                                     goods_sku_id:(NSString *)goods_sku_id
                                         quantity:(NSString *)quantity
{
    confirm_order_from = confirm_order_from?:@"";
    goods_cart_id = goods_cart_id?:@"";
    goods_id = goods_id?:@"";
    goods_sku_id = goods_sku_id?:@"";
    quantity = quantity?:@"";

    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"confirm_order_from":confirm_order_from,
                            @"goods_cart_id":goods_cart_id,
                            @"goods_id":goods_id,
                            @"goods_sku_id":goods_sku_id,
                            @"quantity":quantity
                            };
    
    return [LYHttpHelper POST:API_CONFIRM_ORDER_NORMAL params:prams dealCode:YES];
}

#pragma mark -拼团商品确认下单
- (RACSignal *)confirmGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                             quantity:(NSString *)quantity
{
    activity_group_id = activity_group_id?:@"";
    quantity = quantity?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_group_id":activity_group_id,
                            @"quantity":quantity
                            };
    
    return [LYHttpHelper POST:API_CONFIRM_ORDER_GROUP params:prams dealCode:YES];
}

#pragma mark -秒杀商品确认下单
- (RACSignal *)confirmFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                             quantity:(NSString *)quantity
{
    activity_flash_id = activity_flash_id?:@"";
    quantity = quantity?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_flash_id":activity_flash_id,
                            @"quantity":quantity
                            };
    
    return [LYHttpHelper POST:API_CONFIRM_ORDER_FLASH params:prams dealCode:YES];
}

#pragma mark -积分商品确认下单
- (RACSignal *)confirmScoreOrderWithGoods_id:(NSString *)goods_id
                                goods_sku_id:(NSString *)goods_sku_id
                                    quantity:(NSString *)quantity
{
    goods_id = goods_id?:@"";
    goods_sku_id = goods_sku_id?:@"";
    quantity = quantity?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"goods_id":goods_id,
                            @"goods_sku_id":goods_sku_id,
                            @"quantity":quantity
                            };
    
    return [LYHttpHelper POST:API_CONFIRM_ORDER_STORE params:prams dealCode:YES];
}

#pragma mark -砍价商品确认下单
- (RACSignal *)confirmBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                          bargain_open_id:(NSString *)bargain_open_id
{
    activity_bargain_id = activity_bargain_id?:@"";
    bargain_open_id = bargain_open_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_bargain_id":activity_bargain_id,
                            @"bargain_open_id":bargain_open_id
                            };
    
    return [LYHttpHelper POST:API_CONFIRM_ORDER_BARGAIN params:prams dealCode:YES];
}

@end
