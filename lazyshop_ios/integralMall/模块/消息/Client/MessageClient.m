//
//  MessageClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageClient.h"

#define API_GET_MESSAGE_CENTER   @"http://"APP_DOMAIN@"/message/center"
#define API_GET_MESSAGE_SYSTEM   @"http://"APP_DOMAIN@"/message/system"
#define API_GET_MESSAGE_COUPON   @"http://"APP_DOMAIN@"/message/coupon"
#define API_GET_MESSAGE_SCORE    @"http://"APP_DOMAIN@"/message/score"
#define API_GET_MESSAGE_ORDER    @"http://"APP_DOMAIN@"/message/order"
#define API_GET_MESSAGE_DELETE    @"http://"APP_DOMAIN@"/message/deleteone"
#define API_GET_MESSAGE_DELETE_ALL @"http://"APP_DOMAIN@"/message/deleteall"
#define API_GET_MESSAGE_UNREAD   @"http://"APP_DOMAIN@"/message/unreadcount"
#define API_GET_MESSAGE_SWITCH   @"http://"APP_DOMAIN@"/message/switch/status"
#define API_GET_MESSAGE_SWITCH_UPDATE   @"http://"APP_DOMAIN@"/message/switch/update"

@implementation MessageClient

#pragma mark -消息中心
- (RACSignal *)getMessageCenter
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_CENTER params:prams dealCode:YES];
}

#pragma mark -系统消息
- (RACSignal *)getSystemMessage
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_SYSTEM params:prams dealCode:YES];
}

#pragma mark -优惠券消息
- (RACSignal *)getCouponMessage
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_COUPON params:prams dealCode:YES];
}

#pragma mark -积分消息
- (RACSignal *)getScoreMessageWithPage:(NSString *)page
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_SCORE params:prams dealCode:YES];
}

#pragma mark -订单消息
- (RACSignal *)getOrderMessage
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_ORDER params:prams dealCode:YES];
}

#pragma mark -删除消息
- (RACSignal *)deleteMessageWithApp_message_record_id:(NSString *)app_message_record_id
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"app_message_record_id":app_message_record_id
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_DELETE params:prams dealCode:YES];
}

#pragma mark -删除全部消息
- (RACSignal *)deleteAllMessage
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_DELETE_ALL params:prams dealCode:YES];
}

#pragma mark -未读消息数
- (RACSignal *)fetchUnreadMessageCount
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_MESSAGE_UNREAD params:prams dealCode:YES];
}

#pragma mark -消息开关状态
- (RACSignal *)fetchMessageSwitchStatus
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_MESSAGE_SWITCH params:prams dealCode:YES];
}

#pragma mark -更新消息开关状态
- (RACSignal *)updateMessageSwitchStatusSwitch_type:(NSString *)switch_type
                                       switch_value:(NSString *)switch_value
{
    switch_type = switch_type?:@"";
    switch_value = switch_value?:@"";
    
    NSDictionary *prams = @{
                            @"switch_type":switch_type,
                            @"switch_value":switch_value,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_MESSAGE_SWITCH_UPDATE params:prams dealCode:YES];
}

@end
