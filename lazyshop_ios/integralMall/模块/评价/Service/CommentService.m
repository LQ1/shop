//
//  CommentService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentService.h"

#import "CommentClient.h"
#import "GoodsCommentModel.h"

@interface CommentService()

@property (nonatomic,strong)CommentClient *client;

@end

@implementation CommentService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [CommentClient new];
    }
    return self;
}

- (RACSignal *)getGoodsCommentWithGoods_id:(NSString *)goods_id
{
    return [[self.client getGoodsCommentWithGoods_id:goods_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [GoodsCommentModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无评价");
            return nil;
        }
        return resultArray;
    }];
}

- (RACSignal *)getOrderCommentWithOrder_detail_id:(NSString *)order_detail_id
{
    return [[self.client getOrderCommentWithOrder_detail_id:order_detail_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        GoodsCommentModel *model = [GoodsCommentModel modelFromJSONDictionary:dict[@"data"]];
        if (!model) {
            *errorPtr = AppErrorSetting(@"暂无评价");
            return nil;
        }
        return @[model];
    }];
}

@end
