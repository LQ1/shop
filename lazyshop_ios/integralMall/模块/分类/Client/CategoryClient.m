//
//  CategoryClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryClient.h"

#define API_GET_CATEGROIES @"http://"APP_DOMAIN@"/goods/cat"

@implementation CategoryClient

#pragma mark -获取所有分类
- (RACSignal *)getGoodsCategoryWithType:(NSInteger)type
{
    NSDictionary *prams = @{@"cat_type":@(type)};
    return [LYHttpHelper GET:API_GET_CATEGROIES params:prams dealCode:YES];
}

@end
