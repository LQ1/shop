//
//  LoadDataService.h
//  MobileClassPhone
//
//  Created by cyx on 14/12/4.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSubject;

#define BuildCacheKey(suffix) [NSString stringWithFormat:@"%@_CACHE_%@", self.class, suffix];

typedef NS_ENUM (NSInteger, CacheInfo)
{
    NoCache = 0, //没缓存
    ValidCache = 1, //有缓存
    InValidCache = 2 //缓存过期
};


typedef NS_ENUM (NSInteger, LoadDataMode)
{
    CachePriority = 0, //缓存优先模式，本地缓存没过期从本地取数据，本地没有从网络取数据，如果没有网络就从本地拿数据
    NetPriority = 1   //网络优先模式
};



@protocol LoadDataServiceDelegate <NSObject>

- (RACSignal *)loadNetData:(int)type parameters:(id)params,...;

- (RACSignal *)loadLocalData:(int)type parameters:(id)params,...;

- (CacheInfo)getCacheInfo:(int)type parameters:(id)params,...;

@end

@interface LoadDataService : NSObject<LoadDataServiceDelegate>

/**
 *  缓存优先模式
 *
 *  @param type   接口枚举
 *  @param params 参数
 *
 *  @return 返回信号
 */
- (RACSignal *)loadData:(int)type parameters:(id)params,...;

/**
 *  选择优先模式
 *
 *  @param mode   模式
 *  @param type   接口类型
 *  @param params 参数
 *
 *  @return 返回信号
 */
- (RACSignal *)loadDataWithMode:(LoadDataMode)mode withType:(int)type parameters:(id)params;


/**
 *  网络获取数据
 *
 *  @param type   接口类型
 *  @param params 参数
 *
 *  @return 返回信号
 */
- (RACSignal *)loadNetData:(int)type parameters:(id)params,...;

/**
 *  本地获取数据
 *
 *  @param type   接口类型
 *  @param params 参数
 *
 *  @return 返回信号
 */
- (RACSignal *)loadLocalData:(int)type parameters:(id)params,...;

/**
 *  返回缓存状态
 *
 *  @param type   接口类型
 *  @param params 参数
 *
 *  @return 返回信号
 */
- (CacheInfo)getCacheInfo:(int)type parameters:(id)params,...;




@end
