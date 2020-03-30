//
//  BaseStringProModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/11/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@implementation BaseStringProModel

// 数字转字符串
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [value stringValue];
    }
    [super setValue:value forKey:key];
}

@end
