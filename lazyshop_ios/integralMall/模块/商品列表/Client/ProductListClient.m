//
//  ProductListClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListClient.h"

#define API_GET_PRODUCT_LIST       @"http://"APP_DOMAIN@"/goods/list"
#define API_GET_RECOMMEND_PRODUCT  @"http://"APP_DOMAIN@"/goods/recommend"

@implementation ProductListClient

#pragma mark -获取商品列表
- (RACSignal *)getProductListWithPage:(NSInteger)page
                                 type:(NSInteger)type
                         goods_cat_id:(NSNumber *)goods_cat_id
                          goods_title:(NSString *)goods_title
                            min_score:(NSNumber *)min_score
                            max_score:(NSNumber *)max_score
                           sales_sort:(NSNumber *)sales_sort
                           score_sort:(NSNumber *)score_sort
                           price_sort:(NSNumber *)price_sort
{
    if (page<1) {
        page = 1;
    }
    
    NSDictionary *basePrams = @{
                                @"page":@(page),
                                @"type":@(type)
                               };
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionaryWithDictionary:basePrams];
    if (goods_title.length) {
        [prams setObject:goods_title forKey:@"goods_title"];
    }
    if (goods_cat_id) {
        [prams setObject:goods_cat_id forKey:@"goods_cat_id"];
    }
    if (min_score) {
        [prams setObject:min_score forKey:@"min_score"];
    }
    if (max_score) {
        [prams setObject:max_score forKey:@"max_score"];
    }
    if (sales_sort) {
        [prams setObject:sales_sort forKey:@"sales_sort"];
    }
    if (score_sort) {
        [prams setObject:score_sort forKey:@"score_sort"];
    }
    if (price_sort) {
        [prams setObject:price_sort forKey:@"price_sort"];
    }
    
    return [LYHttpHelper GET:API_GET_PRODUCT_LIST params:prams dealCode:YES];
}

#pragma mark -为你推荐
- (RACSignal *)getRecommendProductListWithPage:(NSString *)page
                                          type:(NSString *)type
{
    page = page?:@"";
    type = type?:@"";

    NSDictionary *prams = @{
                            @"page":page,
                            @"type":type
                            };
    
    return [LYHttpHelper GET:API_GET_RECOMMEND_PRODUCT params:prams dealCode:YES];
}

@end
