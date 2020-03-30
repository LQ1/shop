//
//  ChoiceWareHouseService.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseService.h"

#import "ChoiceWareHouseItemModel.h"
#import "ChoiceWareHouseClient.h"

@interface ChoiceWareHouseService ()

@property (nonatomic, strong) ChoiceWareHouseClient *client;

@end

@implementation ChoiceWareHouseService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [ChoiceWareHouseClient new];
    }
    return self;
}

- (RACSignal *)getWareHouseList
{
    return [[self.client getStoreHouseList] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ChoiceWareHouseItemModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无可选货仓");
            return nil;
        }
        // 校验线上配送
        for (ChoiceWareHouseItemModel *itemModel in resultArray) {
            if (itemModel.storehouse_id == 1) {
                itemModel.sellerPost = YES;
            }
        }
        return resultArray;
    }];
}

@end
