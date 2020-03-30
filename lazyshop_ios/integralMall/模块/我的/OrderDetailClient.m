//
//  OrderDetailClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailClient.h"

#define API_GET_ORDER_DETAIL @"http://"APP_DOMAIN@"/user/order/detail"
#define API_GET_ORDER_APPLY_BACK @"http://"APP_DOMAIN@"/user/order/applyback"

#define API_GET_DELIVER_HANDLE @"http://"APP_DOMAIN@"/deliver/handle"

@implementation OrderDetailClient

#pragma mark -订单详情
- (RACSignal *)fetchOrderDetailWithOrder_id:(NSString *)order_id
{
    order_id = order_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_id":order_id
                            };
    
    return [LYHttpHelper GET:API_GET_ORDER_DETAIL params:prams dealCode:YES];
}

#pragma mark -申请售后
- (RACSignal *)applyBackWithOrder_detail_id:(NSString *)order_detail_id
{
    order_detail_id = order_detail_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"order_detail_id":order_detail_id
                            };
    
    return [LYHttpHelper POST:API_GET_ORDER_APPLY_BACK params:prams dealCode:YES];
}

#pragma mark -快递追踪
- (RACSignal *)getDeliverHandleWithDeliver_id:(NSString *)deliver_id
                                  delivery_no:(NSString *)delivery_no
{
    deliver_id = deliver_id?:@"";
    delivery_no = delivery_no?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"deliver_id":deliver_id,
                            @"delivery_no":delivery_no
                            };
    
    return [LYHttpHelper POST:API_GET_DELIVER_HANDLE params:prams dealCode:YES];
}

@end
