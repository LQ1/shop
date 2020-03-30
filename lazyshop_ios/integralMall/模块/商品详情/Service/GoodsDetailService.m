//
//  GoodsDetailService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailService.h"

#import "GoodsDetailClient.h"

#import "GoodsDetailModel.h"
#import "GoodsTagModel.h"
#import "GoodsCommentModel.h"

#import "GoodsAttrModel.h"
#import "GoodsAttrValueModel.h"
#import "GoodsSkuModel.h"
#import "GoodsDetailIntroduceModel.h"

@interface GoodsDetailService()

@property (nonatomic,strong)GoodsDetailClient *client;

@end

@implementation GoodsDetailService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [GoodsDetailClient new];
    }
    return self;
}

#pragma mark -商品详情
- (RACSignal *)getGoodsDetailWithGoodID:(NSInteger)goodID
                                              activity:(NSString *)activity
                                     activity_flash_id:(NSString *)activity_flash_id
                                   activity_bargain_id:(NSString *)activity_bargain_id
                                     activity_group_id:(NSString *)activity_group_id
{
    return [[self.client getGoodsDetailWithGoodID:goodID
                                         activity:activity
                                activity_flash_id:activity_flash_id
                              activity_bargain_id:activity_bargain_id
                                activity_group_id:activity_group_id] map:^id(NSDictionary *dict) {
        GoodsDetailModel *model = [GoodsDetailModel modelFromJSONDictionary:dict[@"data"]];
        model.goods_tag = [GoodsTagModel modelsFromJSONArray:model.goods_tag];
        model.goods_comment = [GoodsCommentModel modelsFromJSONArray:model.goods_comment];
        model.activity = [GoodsDetailActivityModel modelFromJSONDictionary:(NSDictionary *)model.activity];
        return model;
    }];
}

#pragma mark -商品规格
- (RACSignal *)fetchGoodsAttrWithGoodID:(NSString *)goods_id
{
    return [[self.client fetchGoodsAttrWithGoodID:goods_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [GoodsAttrModel modelsFromJSONArray:dict[@"data"]];
        [resultArray enumerateObjectsUsingBlock:^(GoodsAttrModel *attrModel, NSUInteger idx, BOOL * _Nonnull stop) {
            attrModel.values = [GoodsAttrValueModel modelsFromJSONArray:attrModel.values];
        }];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无数据");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark - 扫合伙人推荐商品海报二维码 绑定关联合伙人
- (RACSignal *)bindPartnerWithScanQRCode:(NSString*)referee_id {
    return [[self.client bindPartnerWithScanQRCode:referee_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        return dict;
    }];
}

#pragma mark -商品sku库存等
- (RACSignal *)fetchGoodsSkuWithGoodsID:(NSString *)goods_id
{
    return [[self.client fetchGoodsSkuWithGoodsID:goods_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [GoodsSkuModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"暂无数据");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -是否已参加砍价
- (RACSignal *)fetchGoodsJoinBargain:(NSString *)activity_bargain_id
{
    return [[self.client fetchGoodsJoinBargain:activity_bargain_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        if ([dict[@"data"][@"is_join"] integerValue] == 1) {
            return @(YES);
        }
        *errorPtr = AppErrorSetting(@"没参加砍价");
        return nil;
    }];
}

#pragma mark -发起砍价
- (RACSignal *)startBargain:(NSString *)activity_bargain_id
{
    return [[self.client startBargain:activity_bargain_id] map:^id(NSDictionary *dict) {
        return dict[@"data"][@"bargain_url"];
    }];
}

/*
 *  是否参与拼团
 */
- (RACSignal *)fetchGoodsJoinGroup:(NSString *)activity_group_id
{
    return [[self.client fetchGoodsJoinGroup:activity_group_id] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        if ([dict[@"data"][@"is_join"] integerValue] == 1) {
            return @(YES);
        }
        *errorPtr = AppErrorSetting(@"没参加拼团");
        return nil;
    }];
}

#pragma mark -获取商品介绍
- (RACSignal *)fetchGoodsIntroduceWithGoods_id:(NSString *)goods_id
{
    return [[self.client fetchGoodsIntroduceWithGoods_id:goods_id] map:^id(NSDictionary *dict) {
        GoodsDetailIntroduceModel *model = [GoodsDetailIntroduceModel modelFromJSONDictionary:dict[@"data"]];
        model.parameter = [GoodsDetailIntroParmModel modelsFromJSONArray:model.parameter];
        return model;
    }];
}

@end
