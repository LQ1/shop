//
//  NSObject+GetStringValue.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NSObject+GetStringValue.h"

@implementation NSObject (GetStringValue)

- (NSString *)lyStringValue
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self stringValue];
    }else if ([self isKindOfClass:[NSString class]]){
        return (NSString *)self;
    }
    return @"";
}

@end
