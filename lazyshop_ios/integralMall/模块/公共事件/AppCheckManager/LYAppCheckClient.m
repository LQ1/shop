//
//  LYAppCheckClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYAppCheckClient.h"

#define API_GET_APP_CHECK @"http://"APP_DOMAIN@"/ischeck"

@implementation LYAppCheckClient

#pragma mark -获取是否审核中
- (RACSignal *)getAppCheckWithVersion:(NSString *)version
{
    version = version?:@"";
    
    NSDictionary *prams = @{
                            @"version":version
                            };
    
    return [LYHttpHelper GET:API_GET_APP_CHECK params:prams dealCode:YES];
}

@end
