//
//  DLPingHelper.m
//  PodTest
//
//  Created by SL on 2016/12/26.
//  Copyright © 2016年 Sheng Long. All rights reserved.
//

#import "DLPingHelper.h"
#import "DLSimplePing.h"
#include <netdb.h>

@interface DLPingHelper ()<DLSimplePingDelegate>

@property (nonatomic, strong) NSString *hostName;

@property (nonatomic, strong) DLSimplePing *pinger;

/**
 *  有很小概率ping失败,设定多少次ping失败认为是断网,默认2次, 必须 >= 2
 */
@property (nonatomic, assign) NSUInteger failureTimes;
@property (nonatomic, strong) NSMutableArray *packetArray;

/**
 *  ping 的频率,默认1s
 */
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *sendTimer;

@end

@implementation DLPingHelper

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc -- %@",self.class);
#endif
}

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (instancetype)simplePingerWithHostName:(NSString *)hostName {
    DLPingHelper *ping = [DLPingHelper new];
    ping.hostName = hostName;
    return ping;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interval = 1.0;
        self.failureTimes = 2;
        self.packetArray = [NSMutableArray new];
    }
    return self;
}

- (void)startNotifier {
    if (self.pinger) {
        [self stopPing];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeOut) object:nil];
    }
    [self.packetArray removeAllObjects];
    // MUST make sure pingFoundation in mainThread
    if ([[NSThread currentThread] isMainThread]) {
        [self startPing];
    } else {
        __weak __typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf startPing];
        });
    }
}

- (void)startPing {
#ifdef DEBUG
    NSLog(@"ping start");
#endif
    DLSimplePing *pinger = [[DLSimplePing alloc] initWithHostName:self.hostName];
    self.pinger = pinger;
    pinger.delegate = self;
    [pinger start];
    [self performSelector:@selector(timeOut) withObject:nil afterDelay:3];
}

- (void)timeOut {
    self.reachable = NO;
}

- (void)stopNotifier {
    [self stopPing];
}

#pragma mark - setter
- (void)setReachable:(BOOL)reachable {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeOut) object:nil];
#ifdef DEBUG
    NSLog(@"ping done");
#endif
    _reachable = reachable;
    if (self.networkStatusDidChanged && self.pinger) {
        self.networkStatusDidChanged();
    }
    [self stopPing];
}

#pragma mark - SimplePing
- (void)sendPing {
    [self.pinger sendPingWithData:nil];
}

- (void)stopPing {
    [self.packetArray removeAllObjects];
    
    [self.pinger stop];
    self.pinger.delegate = nil;
    self.pinger = nil;
    
    [self.sendTimer invalidate];
    self.sendTimer = nil;
}

- (NSString *)displayAddressForAddress:(NSData *)address {
    char *hostStr = malloc(NI_MAXHOST);
    memset(hostStr, 0, NI_MAXHOST);
    BOOL success = getnameinfo((const struct sockaddr *)address.bytes, (socklen_t)address.length, hostStr, (socklen_t)NI_MAXHOST, nil, 0, NI_NUMERICHOST) == 0;
    NSString *result;
    if (success) {
        result = [NSString stringWithUTF8String:hostStr];
    }else{
        result = @"?";
    }
    free(hostStr);
    return result;
}

#pragma mark - SimplePingDelegate
- (void)simplePing:(DLSimplePing *)pinger didStartWithAddress:(NSData *)address {
#ifdef DEBUG
    NSLog(@"ping ip = %@",[self displayAddressForAddress:address]);
#endif
    
    [self sendPing];
    
    if (!self.sendTimer) {
        self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(sendPing)
                                                        userInfo:nil
                                                         repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.sendTimer forMode:NSRunLoopCommonModes];
    }
}

//未知失败,重启ping
- (void)simplePing:(DLSimplePing *)pinger didFailWithError:(NSError *)error {
#ifdef DEBUG
    NSLog(@"ping error = %@", error);
#endif
    
    self.reachable = NO;
}

//发送成功,sequenceNumber范围:0~65535,超范围后从 0 开始
- (void)simplePing:(DLSimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber{
#ifdef DEBUG
    NSLog(@"ping send = %u", sequenceNumber);
#endif

    if(sequenceNumber == 0){
        //重置
        [self.packetArray removeAllObjects];
    }
    
    //根据failuretimes判断是否有网
    if (self.packetArray.count >= self.failureTimes) {
        self.reachable = NO;
    } else {
        //将本次记录加入
        [self.packetArray addObject:@(sequenceNumber)];
    }
}

//发送失败
- (void)simplePing:(DLSimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error {
#ifdef DEBUG
    NSLog(@"ping send fail = %u",sequenceNumber);
#endif

    //发送失败,直接认为断网
    self.reachable = NO;
}

//接收成功
- (void)simplePing:(DLSimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
#ifdef DEBUG
    NSLog(@"ping receive = %@",packet);
#endif

    //有网
    self.reachable = YES;
}

- (void)simplePing:(DLSimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {

}

@end
