//
//  RelateScoreService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RelateScoreService.h"

#import "RelateScoreClient.h"

#import "ScoreItemModel.h"

@interface RelateScoreService()

@property (nonatomic,strong)RelateScoreClient *client;

@end

@implementation RelateScoreService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [RelateScoreClient new];
    }
    return self;
}

#pragma mark -我的店铺列表
- (RACSignal *)getMyScoreList
{
    return [[self.client getMyScoreList] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ScoreItemModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

#pragma mark -我的店铺详情
- (RACSignal *)getMyScoreDetailWithShop_id:(NSString *)shop_id
{
    return [[self.client getMyScoreDetailWithShop_id:shop_id] map:^id(NSDictionary *dict) {
        return [ScoreItemModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

#pragma mark -待关联店铺详情
- (RACSignal *)relateShopDetailWithShop_id:(NSString *)shop_id
{
    return [[self.client relateShopDetailWithShop_id:shop_id] map:^id(NSDictionary *dict) {
        return [ScoreItemModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

#pragma mark -绑定店铺
- (RACSignal *)bindScoreWithShop_id:(NSString *)shop_id
{
    return [[self.client bindScoreWithShop_id:shop_id] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -返利绑定已关联店铺
- (RACSignal *)bindRebateScoreWithShop_id:(NSString *)shop_id
                          order_detail_id:(NSString *)order_detail_id
{
    return [[self.client bindRebateScoreWithShop_id:shop_id
                                   order_detail_id:order_detail_id] map:^id(id value) {
        return @(YES);
    }];
}

@end
