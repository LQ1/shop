//
//  MessageSettingViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageSettingViewModel.h"

#import "MessageSettingItemCellViewModel.h"

#import "MessageService.h"

#define MessageSwitchSystem @"system"
#define MessageSwitchCoupon @"coupon"
#define MessageSwitchScore @"score"
#define MessageSwitchOrder @"order"

@interface MessageSettingViewModel()

@property (nonatomic,strong)MessageService *service;

@end

@implementation MessageSettingViewModel

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
    RACDisposable *disPos = [[self.service fetchMessageSwitchStatus] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        MessageSettingItemCellViewModel *itemVM1 = [MessageSettingItemCellViewModel new];
        itemVM1.type = MessageType_System;
        itemVM1.title = @"平台消息";
        itemVM1.isOff = ![dict[MessageSwitchSystem] boolValue];
        
        MessageSettingItemCellViewModel *itemVM2 = [MessageSettingItemCellViewModel new];
        itemVM2.type = MessageType_Coupon;
        itemVM2.title = @"优惠券消息";
        itemVM2.isOff = ![dict[MessageSwitchCoupon] boolValue];
        
        MessageSettingItemCellViewModel *itemVM3 = [MessageSettingItemCellViewModel new];
        itemVM3.type = MessageType_Score;
        itemVM3.title = @"积分消息";
        itemVM3.isOff = ![dict[MessageSwitchScore] boolValue];
        
        MessageSettingItemCellViewModel *itemVM4 = [MessageSettingItemCellViewModel new];
        itemVM4.type = MessageType_Order;
        itemVM4.title = @"订单消息";
        itemVM4.isOff = ![dict[MessageSwitchOrder] boolValue];
        
        self.dataArray = @[itemVM1,itemVM2,itemVM3,itemVM4];
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageSettingItemCellViewModel *itemVM = [self.dataArray objectAtIndex:indexPath.row];
    
    // 请求接口设置消息开关状态
    NSString *switchValue = [[NSNumber numberWithBool:itemVM.isOff] stringValue];
    NSString *switchType = @"";
    switch (itemVM.type) {
        case MessageType_System:
        {
            switchType = MessageSwitchSystem;
        }
            break;
        case MessageType_Score:
        {
            switchType = MessageSwitchScore;
        }
            break;
        case MessageType_Coupon:
        {
            switchType = MessageSwitchCoupon;
        }
            break;
        case MessageType_Order:
        {
            switchType = MessageSwitchOrder;
        }
            break;
            
        default:
            break;
    }
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service updateMessageSwitchStatusSwitch_type:switchType
                                                                   switch_value:switchValue] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        itemVM.isOff = !itemVM.isOff;
        [self.reloadViewSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -clear
- (void)clearAllMsg
{
    self.loading = YES;
    // 请求接口
    @weakify(self);
    RACDisposable *disPos = [[self.service deleteAllMessage] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:@"清除成功"];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];

}

@end
