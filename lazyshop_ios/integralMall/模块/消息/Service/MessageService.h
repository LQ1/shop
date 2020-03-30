//
//  MessageService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageService : NSObject

/*
 *  全局 未读消息数量
 */
@property (nonatomic,readonly) NSInteger unReadCount;

/*
 *  单例
 */
+ (instancetype)shareInstance;

#pragma mark -消息中心
- (RACSignal *)getMessageCenter;

#pragma mark -系统消息
- (RACSignal *)getSystemMessage;

#pragma mark -优惠券消息
- (RACSignal *)getCouponMessage;

#pragma mark -积分消息
- (RACSignal *)getScoreMessageWithPage:(NSString *)page;

#pragma mark -订单消息
- (RACSignal *)getOrderMessage;

#pragma mark -删除消息
- (RACSignal *)deleteMessageWithApp_message_record_id:(NSString *)app_message_record_id;

#pragma mark -删除全部消息
- (RACSignal *)deleteAllMessage;

#pragma mark -未读消息数
- (void)fetchUnreadMessageCount;
- (void)clearUnreadMessageCount;

#pragma mark -消息开关状态
- (RACSignal *)fetchMessageSwitchStatus;

#pragma mark -更新消息开关状态
- (RACSignal *)updateMessageSwitchStatusSwitch_type:(NSString *)switch_type
                                       switch_value:(NSString *)switch_value;

@end
