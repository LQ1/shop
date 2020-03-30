//
//  RelateScoreClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RelateScoreClient.h"

#define API_GET_SCORE_LIST          @"http://"APP_DOMAIN@"/user/shop/list"
#define API_BIND_MY_SHOP_DETAIL     @"http://"APP_DOMAIN@"/shop/usershop"
#define API_BIND_RELATE_SHOP_DETAIL @"http://"APP_DOMAIN@"/shop/one"
#define API_BIND_SCORE              @"http://"APP_DOMAIN@"/shop/bind"
#define API_REBATE_BIND_SHOP        @"http://"APP_DOMAIN@"/rebate/bindshop"

@implementation RelateScoreClient

#pragma mark -我的店铺列表
- (RACSignal *)getMyScoreList
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_SCORE_LIST params:prams dealCode:YES];
}

#pragma mark -我的店铺详情
- (RACSignal *)getMyScoreDetailWithShop_id:(NSString *)shop_id
{
    shop_id = shop_id?:@"";
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"shop_id":shop_id
                            };
    
    return [LYHttpHelper GET:API_BIND_MY_SHOP_DETAIL params:prams dealCode:YES];
}

#pragma mark -待关联店铺详情
- (RACSignal *)relateShopDetailWithShop_id:(NSString *)shop_id
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"shop_id":shop_id
                            };
    
    return [LYHttpHelper GET:API_BIND_RELATE_SHOP_DETAIL params:prams dealCode:YES];
}

#pragma mark -绑定店铺
- (RACSignal *)bindScoreWithShop_id:(NSString *)shop_id
{
    shop_id = shop_id ?:@"";
    NSDictionary *prams = @{
                            @"shop_id":shop_id,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_BIND_SCORE params:prams dealCode:YES];
}

#pragma mark -返利绑定已关联店铺
- (RACSignal *)bindRebateScoreWithShop_id:(NSString *)shop_id
                          order_detail_id:(NSString *)order_detail_id
{
    shop_id = shop_id ?:@"";
    order_detail_id = order_detail_id ?:@"";
    
    NSDictionary *prams = @{
                            @"shop_id":shop_id,
                            @"order_detail_id":order_detail_id,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_REBATE_BIND_SHOP params:prams dealCode:YES];
}

@end
