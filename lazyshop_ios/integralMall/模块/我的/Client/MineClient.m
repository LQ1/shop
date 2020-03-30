//
//  MineClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineClient.h"

#define API_GET_MINE_TOTAL     @"http://"APP_DOMAIN@"/user/my"
#define API_GET_MINE_REBATE    @"http://"APP_DOMAIN@"/rebate/list"
#define API_GET_REBATE_HISTORY @"http://"APP_DOMAIN@"/rebate/history"
#define API_GET_MINE_GROUP     @"http://"APP_DOMAIN@"/user/grouplist"
#define API_GET_MINE_BARGAIN   @"http://"APP_DOMAIN@"/user/bargainlist"
#define API_GET_USER_INFO      @"http://"APP_DOMAIN@"/user/info"
#define API_UPDATE_USER_INFO   @"http://"APP_DOMAIN@"/user/update"
#define API_GET_APP_VERSION    @"http://"APP_DOMAIN@"/version"
#define API_GET_GROUP_SHARE    @"http://"APP_DOMAIN@"/activity/group/shareinfo"
#define API_GET_BARGAIN_SHARE  @"http://"APP_DOMAIN@"/activity/bargain/shareinfo"
#define API_GET_LAW_CONTENT    @"http://"APP_DOMAIN@"/cms/content"

@implementation MineClient

#pragma mark -获取个人信息
- (RACSignal *)getUserMsg
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_MINE_TOTAL params:prams dealCode:YES];
}

#pragma mark -返利码列表
- (RACSignal *)getMineRebateList
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_MINE_REBATE params:prams dealCode:YES];
}

#pragma mark -返利历史
- (RACSignal *)getRebateHistoryWithPage:(NSString *)page
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_GET_REBATE_HISTORY params:prams dealCode:YES];
}

#pragma mark -我的拼团
- (RACSignal *)getMineGroupWithPage:(NSString *)page
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_GET_MINE_GROUP params:prams dealCode:YES];
}

#pragma mark -我的砍价
- (RACSignal *)getMineBargainWithPage:(NSString *)page
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_GET_MINE_BARGAIN params:prams dealCode:YES];
}

#pragma mark -获取用户信息
- (RACSignal *)getUserInfo
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_USER_INFO params:prams dealCode:YES];
}

#pragma mark -更新用户信息
- (RACSignal *)updateUserInfoField_name:(NSString *)field_name
                            field_value:(NSString *)field_value
{
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"field_name":field_name,
                            @"field_value":field_value
                            };
    
    return [LYHttpHelper POST:API_UPDATE_USER_INFO params:prams dealCode:YES];
}

#pragma mark -获取应用版本号
- (RACSignal *)fetchAppVersion
{
    return [LYHttpHelper GET:API_GET_APP_VERSION params:nil dealCode:YES];
}

#pragma mark -获取团购分享标语
- (RACSignal *)fetchGroupShareInfo
{
    return [LYHttpHelper GET:API_GET_GROUP_SHARE params:nil dealCode:YES];
}

#pragma mark -获取砍价分享标语
- (RACSignal *)fetchBargainShareInfo
{
    return [LYHttpHelper GET:API_GET_BARGAIN_SHARE params:nil dealCode:YES];
}

#pragma mark -获取法律条款
- (RACSignal *)fetchLawContentWithContent_id:(NSString *)content_id
{
    content_id = content_id?:@"";
    
    NSDictionary *prams = @{
                            @"content_id":content_id
                            };

    return [LYHttpHelper GET:API_GET_LAW_CONTENT params:prams dealCode:YES];
}


@end
