//
//  ChoiceWareHouseClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseClient.h"

// 获取货仓列表
#define API_GET_STORE_HOUSE_LIST   @"http://"APP_DOMAIN@"/storehouse/list"
// 下单时选择货仓
#define API_CHOOSE_HOUSE   @"http://"APP_DOMAIN@"/store/choose"

@implementation ChoiceWareHouseClient

#pragma mark -获取货仓列表
- (RACSignal *)getStoreHouseList
{
    return [LYHttpHelper GET:API_GET_STORE_HOUSE_LIST params:nil dealCode:YES];
}

#pragma mark -选择货仓
- (RACSignal *)chooseHouse
{
    return [LYHttpHelper GET:API_GET_STORE_HOUSE_LIST params:nil dealCode:YES];
}


@end
