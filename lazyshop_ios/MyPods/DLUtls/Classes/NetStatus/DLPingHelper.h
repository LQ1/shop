//
//  DLPingHelper.h
//  PodTest
//
//  Created by SL on 2016/12/26.
//  Copyright © 2016年 Sheng Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLPingHelper : NSObject

/**
 *  是否ping的通
 */
@property (nonatomic, assign) BOOL reachable;

/**
 *  回调
 */
@property (nonatomic, copy) void(^networkStatusDidChanged)();

+ (instancetype)simplePingerWithHostName:(NSString *)hostName;

- (void)startNotifier;

- (void)stopNotifier;

@end
