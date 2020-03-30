//
//  MessageService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageService.h"

#import "MessageClient.h"

#import "MessageModel.h"
#import "ScoreMessageModel.h"

@interface MessageService()

@property (nonatomic,strong)MessageClient *client;
@property (nonatomic,assign) NSInteger unReadCount;

@end

@implementation MessageService

#pragma mark -单例
+ (instancetype)shareInstance
{
    static MessageService *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:NULL];
        shareInstance.client = [MessageClient new];
    });
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [MessageService shareInstance];
}

+ (id)copy
{
    return [MessageService shareInstance];
}

#pragma mark -消息中心
- (RACSignal *)getMessageCenter
{
    return [self.client getMessageCenter];
}

#pragma mark -系统消息
- (RACSignal *)getSystemMessage
{
    return [[self.client getSystemMessage] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MessageModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无此类消息");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -优惠券消息
- (RACSignal *)getCouponMessage
{
    return [[self.client getCouponMessage] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MessageModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无此类消息");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -积分消息
- (RACSignal *)getScoreMessageWithPage:(NSString *)page
{
    return [[self.client getScoreMessageWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ScoreMessageModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无此类消息");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -订单消息
- (RACSignal *)getOrderMessage
{
    return [[self.client getOrderMessage] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MessageModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无此类消息");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -删除消息
- (RACSignal *)deleteMessageWithApp_message_record_id:(NSString *)app_message_record_id
{
    return [[self.client deleteMessageWithApp_message_record_id:app_message_record_id] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -删除全部消息
- (RACSignal *)deleteAllMessage
{
    return [[self.client deleteAllMessage] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -未读消息数
// 获取
- (void)fetchUnreadMessageCount
{
    @weakify(self);
    [[self.client fetchUnreadMessageCount] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.unReadCount = [dict[@"data"][@"unread_message_count"] integerValue];
    }];
}
// 清除
- (void)clearUnreadMessageCount
{
    self.unReadCount = 0;
}

#pragma mark -消息开关状态
- (RACSignal *)fetchMessageSwitchStatus
{
    return [[self.client fetchMessageSwitchStatus] map:^id(NSDictionary *dict) {
        return dict[@"data"];
    }];
}

#pragma mark -更新消息开关状态
- (RACSignal *)updateMessageSwitchStatusSwitch_type:(NSString *)switch_type
                                       switch_value:(NSString *)switch_value
{
    return [[self.client updateMessageSwitchStatusSwitch_type:switch_type
                                                switch_value:switch_value] map:^id(id value) {
        return @(YES);
    }];
}

@end
