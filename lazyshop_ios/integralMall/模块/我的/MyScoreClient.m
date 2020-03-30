//
//  MyScoreClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreClient.h"

// 获取用户成长值详情
#define API_GET_GROWTH_DETAIL     @"http://"APP_DOMAIN@"/user/growth/detail"
// 获取用户积分流水列表
#define API_GET_USER_SCORE_LIST     @"http://"APP_DOMAIN@"/user/score/list"

@implementation MyScoreClient

#pragma mark -获取用户成长值详情
- (RACSignal *)getUserGrowthDetail
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_GROWTH_DETAIL params:prams dealCode:YES];
}

#pragma mark -获取用户积分流水列表
- (RACSignal *)getUserScoreListWithChange_type:(NSString *)change_type
                                          page:(NSString *)page
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"change_type":change_type,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_GET_USER_SCORE_LIST params:prams dealCode:YES];
}

@end
