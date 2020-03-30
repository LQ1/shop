//
//  MyScoreService.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreService.h"

#import "MyScoreClient.h"
#import "MyScoreGrowthDetailModel.h"
#import "MyScoreDetailItemModel.h"

@interface MyScoreService ()

@property (nonatomic, strong) MyScoreClient *client;

@end

@implementation MyScoreService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [MyScoreClient new];
    }
    return self;
}

#pragma mark -获取用户成长值详情
- (RACSignal *)getUserGrowthDetail
{
    return [[self.client getUserGrowthDetail] map:^id(NSDictionary *dict) {
        MyScoreGrowthDetailModel *model = [MyScoreGrowthDetailModel modelFromJSONDictionary:dict[@"data"]];
        SignInUser.vipLevel = model.level;
        return model;
    }];
}
#pragma mark -获取用户积分流水列表
- (RACSignal *)getUserScoreListWithChange_type:(NSString *)change_type
                                          page:(NSString *)page
{
    return [[self.client getUserScoreListWithChange_type:change_type
                                                   page:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *array = [MyScoreDetailItemModel modelsFromJSONArray:dict[@"data"][@"list"]];
        if (!array.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无相关数据");
            return nil;
        }
        return array;
    }];
}

@end
