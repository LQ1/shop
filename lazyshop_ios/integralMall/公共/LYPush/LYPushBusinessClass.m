//
//  APServiceBusinessClass.m
//  MobileClassPhone
//
//  Created by SL on 14-9-10.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#import "LYPushBusinessClass.h"

#import <JSONKit-NoWarning/JSONKit.h>
#import <AFNetworking/AFNetworking.h>
#import <MD5Digest/NSString+MD5.h>

#import <DLUtls/CommUtls+DeviceInfo.h>
#import <DLUtls/CommUtls+Time.h>
#import "JPUSHService.h"

// 消息
#import "MessageService.h"
// 订单详情
#import "OrderDetailViewController.h"
#import "OrderDetailViewModel.h"
// 积分消息
#import "ScoreMessageViewController.h"
// 系统消息
#import "SystemMessageViewController.h"
// 我的优惠券
#import "MyCouponsViewController.h"
#import "MyCouponsViewModel.h"

// 绑定设备网址
#define API_UPLOAD_JPUSH_REGIS_ID @"http://"APP_DOMAIN@"/user/binddevice"
// 解绑设备网址
#define API_CANCEL_JPUSH_REGIS_ID @"http://"APP_DOMAIN@"/user/unbinddevice"

// 推送消息类型
typedef NS_ENUM(NSInteger,PushMessageType)
{
    PushMessageType_Order = 1,
    PushMessageType_Score,
    PushMessageType_Coupon,
    PushMessageType_H5,
    PushMessageType_System
};

@interface LYPushBusinessClass()

@end

@implementation LYPushBusinessClass

#pragma mark -单例
+ (instancetype)sharedManager
{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
        [_sharedManager addBadgeObserver];
    });
    return _sharedManager;
}
// 观察设置角标显示
- (void)addBadgeObserver
{
    @weakify(self);
    [[RACObserve([MessageService shareInstance], unReadCount) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue]>0) {
            [self setJPushBadge];
        }else{
            [self cleanJPushBadge];
        }
    }];
}

#pragma mark -注册推送
- (void)registerForRemoteNotificationTypes:(NSDictionary *)launchOptions
                                    appkey:(NSString *)appkey
                          apsForProduction:(BOOL)isProduction
                             ProcessingMsg:(ProcessingPushMsgBlock)block
{
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];

    [JPUSHService setupWithOption:launchOptions
                           appKey:appkey
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    // 如果 App 状态为未运行，此函数将被调用，如果launchOptions包含UIApplicationLaunchOptionsLocalNotificationKey表示用户点击apn 通知导致app被启动运行；如果不含有对应键值则表示 App 不是因点击apn而被启动，可能为直接点击icon被启动或其他。
    NSDictionary *pushInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (pushInfo) {
        // 推送消息
        [self processingPushMessage:pushInfo
                      ProcessingMsg:block
                          showAlert:NO];
    }
}

#pragma mark -注册deviceToken
// 注册deviceToken并绑定registrationID
- (void)registerDeviceToken:(NSData *)deviceToken
{
    if (deviceToken.length>0 &&  deviceToken) {
        [JPUSHService registerDeviceToken:deviceToken];
        // 绑定
        [self setRegistrationID];
    }
}
// 向服务器添加registration_id
- (void)setRegistrationID
{
    NSString *token = SignInToken;
    NSString *registration_id = [JPUSHService registrationID];
    NSString *device_no = [CommUtls getShareUniqueIdentifier];
    NSString *device_name = [CommUtls getModel];
    NSString *system_version = [CommUtls getSystemVersion];
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    if ([AccountService shareInstance].isLogin && token && registration_id.length) {
        
        NSDictionary *params = @{
                                 @"token":token,
                                 @"device_no":device_no,
                                 @"device_name":device_name,
                                 @"system":@(PLATFORM_VALUE),
                                 @"system_version":system_version,
                                 @"registration_id":registration_id,
                                 @"app_version":app_Version
                                 };
        
        [[LYHttpHelper POST:API_UPLOAD_JPUSH_REGIS_ID params:params dealCode:YES] subscribeNext:^(id x) {
            CLog(@"向服务器提交registration_id成功");
        } error:^(NSError *error) {
            CLog(@"向服务器提交registration_id失败==%@",error);
        }];
    }
}
// 取消registration_id
- (void)cancelRegistrationID:(dispatch_block_t)finishBlock
{
    NSString *token = SignInToken;
    if ([AccountService shareInstance].isLogin && token) {
        NSDictionary *params = @{
                                 @"token":token
                                 };
        
        [[LYHttpHelper POST:API_CANCEL_JPUSH_REGIS_ID params:params dealCode:YES] subscribeNext:^(id x) {
            if (finishBlock) {
                finishBlock();
            }
            CLog(@"向服务器提交registration_id成功");
        } error:^(NSError *error) {
            if (finishBlock) {
                finishBlock();
            }
            CLog(@"向服务器提交registration_id失败==%@",error);
        }];
    }
}

#pragma mark -处理推送消息
// 处理推送消息
- (void)processingPushMessage:(NSDictionary *)pushDic
                ProcessingMsg:(ProcessingPushMsgBlock)block
                    showAlert:(BOOL)showAlert
{
    CLog(@"JPush处理推送消息===%@", [pushDic JSONString]);
    // 处理推送信息
    @weakify(self);
    [[[[RACObserve(LYAppDelegate,tabBarController) filter:^BOOL(id value) {
        return value != nil;
    }] delay:.1] take:1] subscribeNext:^(id x) {
        @strongify(self);
        // 重新获取消息数量
        [[MessageService shareInstance] fetchUnreadMessageCount];
        // 处理推送消息
        [self dealPushMessage:pushDic
                    showAlert:showAlert];
        // 向服务器上报收到APNS消息
        [JPUSHService handleRemoteNotification:pushDic];
        // 如果上层设置了信息处理 可交由上层处理
        if (block) {
            block(pushDic);
        }
    }];
}
// 处理具体推送信息
- (void)dealPushMessage:(NSDictionary *)pushDic
              showAlert:(BOOL)showAlert
{
    NSString *msgTitle = @"通知";
    NSString *msgContent = pushDic[@"aps"][@"alert"];

    NSInteger msgType = [pushDic[@"lx"] integerValue];
    switch (msgType) {
        case PushMessageType_Order:
        {
            // 订单推送
            NSString *orderID = [pushDic[@"id"] lyStringValue];
            if (orderID.length) {
                [self showAlertWithTitle:msgTitle
                                 content:msgContent
                             actionBlock:^{
                                 // 跳转订单详情
                                 OrderDetailViewController *vc = [OrderDetailViewController new];
                                 vc.viewModel = [[OrderDetailViewModel alloc] initWithOrderID:orderID orderTitle:@"订单详情"];
                                 vc.hidesBottomBarWhenPushed = YES;
                                 [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc animated:YES];
                             } showAlert:showAlert];
            }
        }
            break;
        case PushMessageType_Score:
        {
            // 积分推送
            [self showAlertWithTitle:msgTitle
                             content:msgContent
                         actionBlock:^{
                             // 跳转积分消息
                             ScoreMessageViewController *vc = [ScoreMessageViewController new];
                             vc.hidesBottomBarWhenPushed = YES;
                             [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc animated:YES];
                         } showAlert:showAlert];
        }
            break;
        case PushMessageType_Coupon:
        {
            // 优惠券推送
            [self showAlertWithTitle:msgTitle
                             content:msgContent
                         actionBlock:^{
                             // 跳转我的优惠券
                             MyCouponsViewController *vc = [MyCouponsViewController new];
                             vc.viewModel = [[MyCouponsViewModel alloc] initWithInValidSelected:NO];
                             vc.hidesBottomBarWhenPushed = YES;
                             [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc animated:YES];
                         } showAlert:showAlert];
        }
            break;
        case PushMessageType_H5:
        {
            // h5推送
            NSString *url = pushDic[@"wz"];
            if (url.length > 0) {
                [self showAlertWithTitle:msgTitle
                                 content:msgContent
                             actionBlock:^{
                                 [PublicEventManager gotoWebDisplayViewControllerWithUrl:url
                                                                    navigationController:nil];
                             } showAlert:showAlert];
            }
        }
            break;
        case PushMessageType_System:
        {
            // 系统消息推送
            [self showAlertWithTitle:msgTitle
                             content:msgContent
                         actionBlock:^{
                             // 跳转系统消息
                             SystemMessageViewController *vc = [SystemMessageViewController new];
                             vc.hidesBottomBarWhenPushed = YES;
                             [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc animated:YES];
                         } showAlert:showAlert];
        }
            break;
            
        default:
        {
            // 普通消息
            [self showAlertWithTitle:msgTitle
                             content:msgContent
                         actionBlock:nil
                           showAlert:YES];
        }
            break;
    }
}
// alert
- (void)showAlertWithTitle:(NSString *)title
                   content:(NSString *)content
               actionBlock:(dispatch_block_t)actionBlock
                 showAlert:(BOOL)showAlert
{
    if (actionBlock) {
        if (showAlert) {
            LYAlertView *alert = [[LYAlertView alloc] initWithTitle:title
                                                            message:content
                                                             titles:@[@"取消",@"查看"]
                                                              click:^(NSInteger index) {
                                                                  if (index == 1) {
                                                                      if (actionBlock) {
                                                                          actionBlock();
                                                                      }
                                                                  }
                                                              }];
            [alert show];
        }else{
            if (actionBlock) {
                actionBlock();
            }
        }
    }else{
        if (showAlert) {
            LYAlertView *alert = [[LYAlertView alloc] initWithTitle:title
                                                            message:content
                                                             titles:@[@"确定"]
                                                              click:nil];
            [alert show];
        }
    }
}

// 设置badge
- (void)setJPushBadge
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MessageService shareInstance].unReadCount];
    [JPUSHService setBadge:[MessageService shareInstance].unReadCount];
}

// 清除JPush服务器对badge值的设定
- (void)cleanJPushBadge
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
}

@end
