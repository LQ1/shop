//
//  InfoHelper.h
//  MobileClassPhone
//
//  Created by cyx on 15/1/9.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoHelper : NSObject

/**
 *  获取引导图版本号
 *
 *  @return 版本号
 */
+ (NSInteger)guidVersion;
/**
 *  设置引导图版本号
 *
 *  @param currVersion 当前版本
 */
+ (void)recordGuidVersion:(NSInteger)currVersion;


@end
