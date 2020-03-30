//
//  MyOrdersClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersClient.h"

#define API_MY_ORDERS_LIST @"http://"APP_DOMAIN@"/user/order/list"
#define API_MY_ORDERS_DELETE @"http://"APP_DOMAIN@"/user/order/delete"
#define API_MY_ORDERS_CONFIRM @"http://"APP_DOMAIN@"/user/order/receipt"
#define API_MY_ORDERS_CANCEL @"http://"APP_DOMAIN@"/user/order/cancel"

#define API_MY_ORDERS_BACK @"http://"APP_DOMAIN@"/user/order/backlist"

@implementation MyOrdersClient

#pragma mark -我的订单
- (RACSignal *)fetchMyOrdersListWithOrder_status:(NSString *)order_status
                                            page:(NSString *)page
{
    order_status = order_status?:@"";
    page = page?:@"";
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_status":order_status,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_MY_ORDERS_LIST params:prams dealCode:YES];
}

#pragma mark -删除订单
- (RACSignal *)deleteOrderWithOrder_id:(NSString *)order_id
{
    order_id = order_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_id":order_id
                            };
    
    return [LYHttpHelper POST:API_MY_ORDERS_DELETE params:prams dealCode:YES];
}

#pragma mark -确认收货
- (RACSignal *)confirmOrderWithOrder_id:(NSString *)order_id
{
    order_id = order_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_id":order_id
                            };
    
    return [LYHttpHelper POST:API_MY_ORDERS_CONFIRM params:prams dealCode:YES];
}

#pragma mark -取消订单
- (RACSignal *)cancelOrderWithOrder_id:(NSString *)order_id
{
    order_id = order_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_id":order_id
                            };
    
    return [LYHttpHelper POST:API_MY_ORDERS_CANCEL params:prams dealCode:YES];
}

#pragma mark -退款/维修 列表
- (RACSignal *)backListWithPage:(NSString *)page
{
    page = page?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_MY_ORDERS_BACK params:prams dealCode:YES];
}

@end
