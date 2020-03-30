//
//  ThirdStatisticsHelper.m
//  MobileClassPhone
//
//  Created by cyx on 14/12/23.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import "ThirdStatisticsHelper.h"
#import <UMMobClick/MobClick.h>
#import <CommUtls+DeviceInfo.h>

@implementation ThirdStatisticsHelper


+ (void)startWithAppkey:(NSString *)appKey
{
    UMConfigInstance.appKey = appKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#endif
}


+ (void)event:(NSString *)eventID
{
    [MobClick event:eventID];
}

+ (void)setAppversion
{
#ifdef DEBUG
    [MobClick setAppVersion:@"1000"];
#else
    [MobClick setAppVersion:[CommUtls getSoftShowVersion]];
#endif
}


+ (void)beginPage:(NSString *)pageName
{
    [MobClick beginLogPageView:pageName];
}


+ (void)endPage:(NSString *)pageName
{
    [MobClick endLogPageView:pageName];
}

@end
