//
//  FeedBackClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackClient.h"

#define API_ADD_SUGGEST @"http://"APP_DOMAIN@"/suggest/add"

@implementation FeedBackClient

#pragma mark -订单详情
- (RACSignal *)submitFeedBackWithType:(NSString *)type
                              content:(NSString *)content
                               mobile:(NSString *)mobile
{
    type = type?:@"";
    content = content?:@"";
    mobile = mobile?:@"";

    NSDictionary *prams = @{
                            @"type":type,
                            @"content":content,
                            @"mobile":mobile
                            };
    
    return [LYHttpHelper POST:API_ADD_SUGGEST params:prams dealCode:YES];
}

@end
