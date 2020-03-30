//
//  NetStatusHelper.m
//  MobileClassPhone
//
//  Created by cyx on 14/12/4.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import "NetStatusHelper.h"
#import "DLReachability.h"
#import "DLPingHelper.h"

#define Host_Name               @"www.baidu.com"

NSString *const kNetStatusHelperChangedNotification = @"kNetStatusHelperChangedNotification";

@interface NetStatusHelper ()

@property (atomic, strong) DLReachability *reachability;

@property (atomic, strong) DLPingHelper *pinger;
@property (atomic, assign) NSInteger isPinging;

/**
 是否允许每次ping网络
 */
@property (atomic, assign) BOOL allowPing;

@end

@implementation NetStatusHelper

static NetStatusHelper *sharedObj = nil;

+ (NetStatusHelper* )sharedInstance {
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

- (void)dealloc {
    [self stopNotifier];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _netStatus = NoneNet;
        
        //使用[Reachability reachabilityForInternetConnection]则通知不会执行2次
        DLReachability *reachability = [DLReachability reachabilityWithHostName:Host_Name];
//        DLReachability *reachability = [DLReachability reachabilityForInternetConnection];
        self.reachability = reachability;
        
        DLPingHelper *pinger = [DLPingHelper simplePingerWithHostName:Host_Name];
        self.pinger = pinger;
    }
    return self;
}

- (void)startNotifier {
    __block BOOL pingDone = NO;
    [self reachabilityChange:^{
#ifdef DEBUG
        NSLog(@"sync netstatus done");
#endif
        pingDone = YES;
    }];
    //ping 3s超时，这里设置4s
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:4];
    while (!pingDone) {
#ifdef DEBUG
        NSLog(@"wait");
#endif
        //主线程等待，但让出主线程时间片；有事件到达就返回，如果没有则过4秒返回。
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:date];
    }
    //必须放在获取网络的下面，不然有几率导致currentReachabilityStatus方法有网但是第一次获取的是无网状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChange)
                                                 name:kDLReachabilityChangedNotification
                                               object:nil];
    [self.reachability startNotifier];
#ifdef DEBUG
    NSLog(@"endNotifier");
#endif
}

/**
 开启网络监听，且每次切换网络之后都会ping下
 */
- (void)startNotifierPing {
    self.allowPing = YES;
    [self startNotifierPing];
}

- (void)stopNotifier {
    self.pinger.networkStatusDidChanged = nil;
    [self.pinger stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kDLReachabilityChangedNotification
                                                  object:nil];
}

- (void)reachabilityChange {
    [self reachabilityChange:nil];
}

- (void)reachabilityChange:(void(^)())first {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
#ifdef DEBUG
    NSLog(@"Reachability网络状态改变 = %@",(status==ReachableViaWiFi?@"wifi":(status==ReachableViaWWAN?@"移动":@"无")));
#endif
    if (status == NotReachable) {
        if (status != _netStatus) {
            self.pinger.networkStatusDidChanged = nil;
            [self.pinger stopNotifier];
            self.isPinging = -1;

            _netStatus = (NetStatus)status;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetStatusHelperChangedNotification
                                                                object:nil
                                                              userInfo:@{@"netstatus":@(_netStatus)}];
#ifdef DEBUG
            NSLog(@"切换到 无 网络");
#endif
        }
        if (first) {
            first();
        }
    } else if (self.isPinging != status) {
        if ((status == ReachableViaWiFi && _netStatus != Wifi_Net) || (status == ReachableViaWWAN && _netStatus != Mobile_Net)) {
            self.isPinging = status;
            if (self.allowPing || first) {
                __weak typeof(self) weakSelf = self;
                [self.pinger setNetworkStatusDidChanged:^{
                    [weakSelf networkStatusDidChanged:(first!=nil)];
                    if (first) {
                        first();
                    }
                }];
                [self.pinger startNotifier];
            } else {
                [self networkStatusDidChanged:(first!=nil)];
            }
        }
    }
}

- (void)networkStatusDidChanged:(BOOL)first {
    //获取两种方法得到的联网状态,并转为BOOL值
    NetworkStatus status1 = [self.reachability currentReachabilityStatus];
    BOOL status2 = YES;
    if (self.allowPing || first) {
        status2 = self.pinger.reachable;
    }
    
    //综合判断网络,判断原则:Reachability -> pinger
    NetStatus status = NoneNet;
    if (status1 && status2) {
        //有网
        if (status1 == ReachableViaWiFi) {
            status = Wifi_Net;
        } else if (status1 == ReachableViaWWAN) {
            status = Mobile_Net;
        }
    }
#ifdef DEBUG
    NSLog(@"reachability = %@ and pinger = %@",status1==ReachableViaWiFi?@"wifi":@"移动",status2?@"成功":@"失败");
    NSLog(@"old = %@ and new = %@",(_netStatus==Wifi_Net?@"wifi":(_netStatus==Mobile_Net?@"移动":@"无")),(status==Wifi_Net?@"wifi":(status==Mobile_Net?@"移动":@"无")));
#endif
    if (status != _netStatus) {
        _netStatus = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetStatusHelperChangedNotification
                                                            object:nil
                                                          userInfo:@{@"netstatus":@(_netStatus)}];
#ifdef DEBUG
        NSLog(@"切换到 %@ 网络",(_netStatus==Wifi_Net?@"wifi":(_netStatus==Mobile_Net?@"移动":@"无")));
#endif
    }
    self.isPinging = -1;
}

@end
