//
//  ThirdStatisticsHelper.h
//  MobileClassPhone
//
//  Created by cyx on 14/12/23.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdStatisticsHelper : NSObject

+ (void)startWithAppkey:(NSString *)appKey;

+ (void)event:(NSString *)eventID;

+ (void)setAppversion;

+ (void)beginPage:(NSString *)pageName;

+ (void)endPage:(NSString *)pageName;


@end
