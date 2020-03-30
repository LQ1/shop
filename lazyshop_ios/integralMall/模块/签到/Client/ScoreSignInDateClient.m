//
//  ScoreSignInDateClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInDateClient.h"

// 签到
#define API_SIGN_IN     @"http://"APP_DOMAIN@"/sign/in"
// 获取签到列表
#define API_GET_SIGN_IN     @"http://"APP_DOMAIN@"/sign/in/list"

@implementation ScoreSignInDateClient

#pragma mark -签到
- (RACSignal *)signIn
{
    //NSString *signInTime = [CommUtls encodeTime:[NSDate date]];
    NSDictionary *prams = @{
                            @"token":SignInToken,
    //                        @"sign_in_time":signInTime
                            };
    
    return [LYHttpHelper POST:API_SIGN_IN params:prams dealCode:YES];
}

#pragma mark -获取签到信息
- (RACSignal *)fetchSignInList
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_SIGN_IN params:prams dealCode:YES];
}

@end
