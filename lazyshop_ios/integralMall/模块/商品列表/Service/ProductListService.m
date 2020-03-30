//
//  ProductListService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListService.h"

#import "ProductListClient.h"
#import "ProductListItemModel.h"

@interface ProductListService()

@property (nonatomic,strong)ProductListClient *client;

@end

@implementation ProductListService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [ProductListClient new];
    }
    return self;
}

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
    return [[self.client getProductListWithPage:page
                                          type:type
                                  goods_cat_id:goods_cat_id
                                   goods_title:goods_title
                                     min_score:min_score
                                     max_score:max_score
                                    sales_sort:sales_sort
                                    score_sort:score_sort
                                    price_sort:price_sort] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ProductListItemModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

#pragma mark -为你推荐
- (RACSignal *)getRecommendProductListWithPage:(NSString *)page
                                          type:(NSString *)type
{
    return [[self.client getRecommendProductListWithPage:page
                                                   type:type] map:^id(NSDictionary *dict) {
        NSArray *resultArray = [ProductListItemModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

@end
