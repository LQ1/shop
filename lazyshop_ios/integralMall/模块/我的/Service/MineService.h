//
//  MineService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineService : NSObject

/*
 *  获取个人信息
 */
- (RACSignal *)getUserMsg;

/*
 *  获取返利码列表
 */
- (RACSignal *)getMineRebateList;

#pragma mark -返利历史
- (RACSignal *)getRebateHistoryWithPage:(NSString *)page;

#pragma mark -我的拼团
- (RACSignal *)getMineGroupWithPage:(NSString *)page;

#pragma mark -我的砍价
- (RACSignal *)getMineBargainWithPage:(NSString *)page;

#pragma mark -获取用户信息
- (RACSignal *)getUserInfo;

#pragma mark -更新用户信息
- (RACSignal *)updateUserInfoField_name:(NSString *)field_name
                            field_value:(NSString *)field_value;

#pragma mark -获取应用版本号
- (RACSignal *)fetchAppVersion;

#pragma mark -获取团购分享标语
- (RACSignal *)fetchGroupShareInfo;

#pragma mark -获取砍价分享标语
- (RACSignal *)fetchBargainShareInfo;

#pragma mark -获取法律条款
- (RACSignal *)fetchLawContentWithContent_id:(NSString *)content_id;

@end
