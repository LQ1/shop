//
//  MineService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineService.h"

#import "MineClient.h"

#import "CashBackModel.h"
#import "CashBackHistoryModel.h"

#import "PersonalMessageModel.h"
#import "MyGroupBuyModel.h"
#import "MyBargainModel.h"
#import "LawContentModel.h"
#import "UpdateMsgModel.h"

@interface MineService()

@property (nonatomic,strong) MineClient *client;

@end

@implementation MineService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [MineClient new];
    }
    return self;
}

/*
 *  获取个人信息
 */
- (RACSignal *)getUserMsg
{
    return [[self.client getUserMsg] map:^id(NSDictionary *oldDict) {
        NSDictionary *dict = oldDict[@"data"];
        // 订单
        SignInUser.waitToPayOrdersNumber = [dict[@"not_pay_total"] integerValue];
        SignInUser.waitToSendOrdersNumber = [dict[@"wait_receive_total"] integerValue];
        SignInUser.waitToRecommendOrdersNumber = [dict[@"wait_comment_total"] integerValue];
        SignInUser.waitToRefoundOrdersNumber = [dict[@"wait_service_total"] integerValue];
        // 优惠券
        SignInUser.couponTotalNumber = [dict[@"coupon_total"] integerValue];
        // 拼团砍价
        SignInUser.myGroupByOrdersNumber = [dict[@"group_total"] integerValue];
        SignInUser.myBargainOrdersNumber = [dict[@"bargain_total"] integerValue];
        // 头像
        SignInUser.headImageUrl = dict[@"avatar"];
        // 昵称
        SignInUser.nickName = dict[@"nickname"];
        // 积分
        SignInUser.integralTotalNumber = [dict[@"score"] integerValue];
        
        SignInUser.partner = [PartnerModel new];
        NSDictionary *dctPartner  = dict[@"partner"];
        SignInUser.partner.link_type = [dctPartner[@"link_type"] intValue];
        SignInUser.partner.advert_id = [dctPartner[@"advert_id"] intValue];
        SignInUser.partner.placeholder_id = [dctPartner[@"placeholder_id"] intValue];
        SignInUser.partner.image = dctPartner[@"image"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:SignInUser.partner.image]];
        SignInUser.partner.picImage = [UIImage imageWithData:imageData];
        
        return @(YES);
    }];
}

/*
 *  获取返利码列表
 */
- (RACSignal *)getMineRebateList
{
    return [[self.client getMineRebateList] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [CashBackModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"返利列表为空");
            return nil;
        }
        [resultArray enumerateObjectsUsingBlock:^(CashBackModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.rebate_code = [CashBackRebateCodeModel modelsFromJSONArray:obj.rebate_code];
        }];
        
        return resultArray;
    }];
}

#pragma mark -返利历史
- (RACSignal *)getRebateHistoryWithPage:(NSString *)page
{
    return [[self.client getRebateHistoryWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [CashBackHistoryModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无返现历史");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -我的拼团
- (RACSignal *)getMineGroupWithPage:(NSString *)page
{
    return [[self.client getMineGroupWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MyGroupBuyModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"您还没有拼团");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -我的砍价
- (RACSignal *)getMineBargainWithPage:(NSString *)page
{
    return [[self.client getMineBargainWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MyBargainModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"您还没有砍价");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -获取用户信息
- (RACSignal *)getUserInfo
{
    return [[self.client getUserInfo] map:^id(NSDictionary *dict) {
        return [PersonalMessageModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

#pragma mark -更新用户信息
- (RACSignal *)updateUserInfoField_name:(NSString *)field_name
                            field_value:(NSString *)field_value
{
    return [[self.client updateUserInfoField_name:field_name
                                     field_value:field_value] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -获取应用版本号
- (RACSignal *)fetchAppVersion
{
    return [[self.client fetchAppVersion] map:^id(NSDictionary *dict) {
        UpdateMsgModel *model = [UpdateMsgModel modelFromJSONDictionary:dict[@"data"]];
        return model;
    }];
}

#pragma mark -获取团购分享标语
- (RACSignal *)fetchGroupShareInfo
{
    return [[self.client fetchGroupShareInfo] map:^id(NSDictionary *dict) {
        return dict[@"data"];
    }];
}

#pragma mark -获取砍价分享标语
- (RACSignal *)fetchBargainShareInfo
{
    return [[self.client fetchBargainShareInfo] map:^id(NSDictionary *dict) {
        return dict[@"data"];
    }];
}

#pragma mark -获取法律条款
- (RACSignal *)fetchLawContentWithContent_id:(NSString *)content_id
{
    return [[self.client fetchLawContentWithContent_id:content_id] map:^id(NSDictionary *dict) {
        return [LawContentModel modelFromJSONDictionary:dict[@"data"]];
    }];
}

@end
