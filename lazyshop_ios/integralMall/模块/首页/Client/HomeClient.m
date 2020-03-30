//
//  HomeClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeClient.h"

#define API_GET_HOME_ACTIVITY @"http://"APP_DOMAIN@"/index/adandactivity"
#define API_GET_HOME_PRODUCTS @"http://"APP_DOMAIN@"/index/goods"

#define API_GET_SECKILL_TIMES  @"http://"APP_DOMAIN@"/activity/flash/time"
#define API_GET_SECKILL_LIST  @"http://"APP_DOMAIN@"/activity/flash/list"

#define API_GET_GROUP_LIST    @"http://"APP_DOMAIN@"/activity/group/list"

#define API_GET_BARGAIN_LIST  @"http://"APP_DOMAIN@"/activity/bargain/list"

#define API_GET_GOODS_ID_WITH_CODE  @"http://"APP_DOMAIN@"/html/qrcode"

@implementation HomeClient

#pragma mark -获取首页活动
- (RACSignal *)fetchHomeActivitys
{
    return [LYHttpHelper GET:API_GET_HOME_ACTIVITY params:nil dealCode:YES];
}

#pragma mark -获取首页商品列表
- (RACSignal *)fetchHomeGoodsListWithPage:(NSString *)page
{
    NSDictionary *prams = @{@"page":page};

    return [LYHttpHelper GET:API_GET_HOME_PRODUCTS params:prams dealCode:YES];
}

#pragma mark -秒杀
// 秒杀时间
- (RACSignal *)fetchSecKillTimes
{
    return [LYHttpHelper GET:API_GET_SECKILL_TIMES params:nil dealCode:YES];
}
// 秒杀列表
- (RACSignal *)fetchSecKillListWithPage:(NSString *)page
                          sell_start_at:(NSString *)sell_start_at
{
    page = page?:@"";
    sell_start_at = sell_start_at?:@"";
    
    NSDictionary *prams = @{
                            @"page":page,
                            @"sell_start_at":sell_start_at
                            };
    
    return [LYHttpHelper GET:API_GET_SECKILL_LIST params:prams dealCode:YES];
}

#pragma mark -获取拼团列表
- (RACSignal *)fetchGroupBuyListWithPage:(NSString *)page
{
    NSDictionary *prams = @{@"page":page};

    return [LYHttpHelper GET:API_GET_GROUP_LIST params:prams dealCode:YES];
}

#pragma mark -获取砍价列表
- (RACSignal *)fetchBargainListWithPage:(NSString *)page
{
    NSDictionary *prams = @{@"page":page};

    return [LYHttpHelper GET:API_GET_BARGAIN_LIST params:prams dealCode:YES];
}

#pragma mark -扫一扫获取商品信息
- (RACSignal *)fetchGoodsMsgWithScanCode:(NSString *)scanCode
{
    scanCode = scanCode?:@"";
    
    NSDictionary *prams = @{@"url":scanCode};
    
    return [LYHttpHelper GET:API_GET_GOODS_ID_WITH_CODE params:prams dealCode:YES];
}


@end
