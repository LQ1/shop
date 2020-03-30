//
//  InfoHelper.m
//  MobileClassPhone
//
//  Created by cyx on 15/1/9.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import "InfoHelper.h"

@implementation InfoHelper

+ (NSInteger)guidVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"guid_version"];
}

+ (void)recordGuidVersion:(NSInteger)currVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:currVersion forKey:@"guid_version"];
    [defaults synchronize];
}

@end
