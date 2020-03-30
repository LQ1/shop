//
//  MessageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageViewModel.h"

#import "MessageListCellViewModel.h"

#import "MessageService.h"

@interface MessageViewModel()

@property (nonatomic,strong)MessageService *service;

@end

@implementation MessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MessageService new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getMessageCenter] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithDict:x];
    } error:^(NSError *error) {
        @strongify(self);
        [self dealDataWithDict:nil];
        CLog(@"消息中心数据获取失败:%@",error);
    }];
    [self addDisposeSignal:disPos];
}

// 处理数据
- (void)dealDataWithDict:(NSDictionary *)dict
{
    // 系统消息
    NSString *sysMsgContent = dict[@"data"][@"system"][@"message"][@"msg_content"];
    NSString *sysMsgCount = [dict[@"data"][@"system"][@"count"] lyStringValue];
    NSString *sysMsgTime = dict[@"data"][@"system"][@"message"][@"created_at"];

    MessageListCellViewModel *systemVM = [[MessageListCellViewModel alloc] initWithImageName:@"系统消息图标" title:@"平台消息" detailTitle:sysMsgContent time:sysMsgTime msgCount:sysMsgCount type:MessageType_System];
    
    // 优惠券消息
    NSString *couponMsgContent = dict[@"data"][@"coupon"][@"message"][@"msg_content"];
    NSString *couponMsgCount = [dict[@"data"][@"coupon"][@"count"] lyStringValue];
    NSString *couponMsgTime = dict[@"data"][@"coupon"][@"message"][@"created_at"];

    MessageListCellViewModel *couponVM = [[MessageListCellViewModel alloc] initWithImageName:@"优惠券消息图标" title:@"优惠券消息" detailTitle:couponMsgContent time:couponMsgTime msgCount:couponMsgCount type:MessageType_Coupon];
    
    // 积分消息
    NSString *scoreMsgContent = dict[@"data"][@"score"][@"message"][@"msg_content"];
    NSString *scoreMsgCount = [dict[@"data"][@"score"][@"count"] lyStringValue];
    NSString *scoreMsgTime = dict[@"data"][@"score"][@"message"][@"created_at"];

    MessageListCellViewModel *storeVM = [[MessageListCellViewModel alloc] initWithImageName:@"积分消息图标-" title:@"积分消息" detailTitle:scoreMsgContent time:scoreMsgTime msgCount:scoreMsgCount type:MessageType_Score];
    
    // 订单消息
    NSString *orderMsgContent = dict[@"data"][@"order"][@"message"][@"msg_content"];
    NSString *orderMsgCount = [dict[@"data"][@"order"][@"count"] lyStringValue];
    NSString *orderMsgTime = dict[@"data"][@"order"][@"message"][@"created_at"];

    MessageListCellViewModel *orderVM = [[MessageListCellViewModel alloc] initWithImageName:@"订单消息图标" title:@"订单消息" detailTitle:orderMsgContent time:orderMsgTime msgCount:orderMsgCount type:MessageType_Order];
    
    self.dataArray = @[systemVM,couponVM,storeVM,orderVM];
    [self.fetchListSuccessSignal sendNext:nil];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.section];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListCellViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    switch (itemVM.type) {
        case MessageType_System:
        {
            self.currentSignalType = MineViewModel_Signal_Type_GotoSystemMsg;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MessageType_Coupon:
        {
            self.currentSignalType = MineViewModel_Signal_Type_GotoCouponMsg;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MessageType_Score:
        {
            self.currentSignalType = MineViewModel_Signal_Type_GotoScoreMsg;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
        case MessageType_Order:
        {
            self.currentSignalType = MineViewModel_Signal_Type_GotoOrderMsg;
            [self.updatedContentSignal sendNext:nil];
        }
            break;
            
        default:
            break;
    }
    
}

@end
