//
//  CategoryService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryService.h"

#import "CategoryClient.h"
#import "CategoryModel.h"

@interface CategoryService()

@property (nonatomic,strong)CategoryClient *client;

@end

@implementation CategoryService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [CategoryClient new];
    }
    return self;
}

/*
 *  获取商品分类
 */
- (RACSignal *)getGoodsCategoryWithType:(NSInteger)type
{
    return [[self.client getGoodsCategoryWithType:type] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [CategoryModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无商品分类信息");
            return nil;
        }
        // 获取数据成功
        [resultArray enumerateObjectsUsingBlock:^(CategoryModel *firstModel, NSUInteger idx, BOOL * _Nonnull stop) {
            firstModel.child = [CategoryModel modelsFromJSONArray:firstModel.child];
            [firstModel.child enumerateObjectsUsingBlock:^(CategoryModel *secondModel, NSUInteger idx, BOOL * _Nonnull stop) {
                secondModel.child = [CategoryModel modelsFromJSONArray:secondModel.child];
            }];
        }];
        return resultArray;
    }];
}

@end
