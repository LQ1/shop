//
//  CommentCenterService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterService.h"

#import "CommentCenterClient.h"
#import "CommentCenterModel.h"

@interface CommentCenterService()

@property (nonatomic,strong) CommentCenterClient *client;

@end

@implementation CommentCenterService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [CommentCenterClient new];
    }
    return self;
}

/*
 *  评价列表
 */
- (RACSignal *)getCommentListWithIs_comment:(NSString *)is_comment
                                       page:(NSString *)page
{
    return [[self.client getCommentListWithIs_comment:is_comment
                                                page:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [CommentCenterModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

#pragma mark -添加评价
- (RACSignal *)addCommentWithOrder_detail_id:(NSString *)order_detail_id
                                     content:(NSString *)content
                                       image:(NSString *)image
{
    return [[self.client addCommentWithOrder_detail_id:order_detail_id
                                              content:content
                                                image:image] map:^id(id value) {
        return @(YES);
    }];
}

@end
