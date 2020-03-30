//
//  SecKillCountDownManager.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SecKillTimeModel;

@interface SecKillCountDownManager : NSObject

@property (nonatomic,readonly) BOOL isInKilling;
@property (nonatomic,readonly) NSString *killTime;
@property (nonatomic,readonly) NSInteger validSeconds;

/*
 *  单例
 */
+ (SecKillCountDownManager *)sharedInstance;

/*
 *  获取秒杀时间段 需订阅（秒杀列表头部显示使用）
 */
- (RACSignal *)fetchSecKillTimes;

/*
 *  获取秒杀时间段 不需订阅（为了设置manager数据）
 */
- (void)refetchNetTimes;

@end
