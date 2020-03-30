//
//  HomeService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeService.h"

#import "HomeClient.h"

#import "HomeContentModel.h"

#import "HomeLeisureItemModel.h"
#import "ProductRowBaseModel.h"
#import "ProductListItemModel.h"
#import "SecKillTimeModel.h"
#import "PartnerModel.h"

@interface HomeService()

@property (nonatomic,strong)HomeClient *client;

@end

@implementation HomeService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [HomeClient new];
    }
    return self;
}

#pragma mark -获取首页活动
- (RACSignal *)fetchHomeActivitys
{
    return [[self.client fetchHomeActivitys] map:^id(NSDictionary *dict) {
        HomeContentModel *model = [HomeContentModel modelFromJSONDictionary:dict[@"data"]];
        // 轮询图
        model.banner = [HomeCycleItemModel modelsFromJSONArray:model.banner];
        [model.banner enumerateObjectsUsingBlock:^(HomeCycleItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.link = [HomeLinkModel modelFromJSONDictionary:(NSDictionary *)obj.link];
            obj.link.options = [HomeLinkNativeModel modelFromJSONDictionary:(NSDictionary *)obj.link.options];
        }];
        // 分类
        model.navcat = [HomeCategoryItemModel modelsFromJSONArray:model.navcat];
        //合伙人
        model.partner = [PartnerModel modelFromJSONDictionary:(NSDictionary *)model.partner];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.partner.image]];
        model.partner.picImage = [UIImage imageWithData:imageData];
        [AccountService shareInstance].partner = model.partner;
        
        // 积分商城
        model.integralCat = [HomeScoreScrollItemModel modelsFromJSONArray:model.integralCat];
        model.integralThumb = dict[@"data"][@"integralList"][@"goods_cat_thumb"];
        // 休闲娱乐
        model.leisure = [HomeLeisureItemModel modelsFromJSONArray:model.leisure];
        // 秒团砍
        model.flash = [HomeSecKillItemModel modelsFromJSONArray:model.flash];
        model.group = [HomeGroupByItemModel modelsFromJSONArray:model.group];
        model.bargain = [HomeBargainItemModel modelsFromJSONArray:model.bargain];
        // 懒店精选
        model.selected = [HomeSelectedScrollItemModel modelsFromJSONArray:model.selected];
        model.brandRecommend = [HomeSelectedRecomModel modelFromJSONDictionary:(NSDictionary *)model.brandRecommend];
        model.brandRecommend.brand = [HomeSelectedRecomItemModel modelsFromJSONArray:model.brandRecommend.brand];
        // 懒店推荐
        model.foot_banner = [HomeCycleItemModel modelsFromJSONArray:model.foot_banner];
        [model.foot_banner enumerateObjectsUsingBlock:^(HomeCycleItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.link = [HomeLinkModel modelFromJSONDictionary:(NSDictionary *)obj.link];
            obj.link.options = [HomeLinkNativeModel modelFromJSONDictionary:(NSDictionary *)obj.link.options];
        }];

        return model;
    }];
}

#pragma mark -获取首页商品列表
- (RACSignal *)fetchHomeGoodsListWithPage:(NSString *)page
{
    return [[self.client fetchHomeGoodsListWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ProductListItemModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

#pragma mark -秒杀
// 获取秒杀时间
- (RACSignal *)fetchSecKillTimes
{
    return [[self.client fetchSecKillTimes] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        SecKillTimeModel *model = [SecKillTimeModel modelFromJSONDictionary:dict[@"data"]];
        model.time_slice = [SecKillTimePointModel modelsFromJSONArray:model.time_slice];
        return model;
    }];
}
// 获取秒杀列表
- (RACSignal *)fetchSecKillListWithPage:(NSString *)page
                          sell_start_at:(NSString *)sell_start_at
{
    return [[self.client fetchSecKillListWithPage:page
                                   sell_start_at:sell_start_at] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ProductRowBaseModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"商品列表为空");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -获取拼团列表
- (RACSignal *)fetchGroupBuyListWithPage:(NSString *)page
{
    return [[self.client fetchGroupBuyListWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ProductRowBaseModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"拼团列表为空");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -获取砍价列表
- (RACSignal *)fetchBargainListWithPage:(NSString *)page
{
    return [[self.client fetchBargainListWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ProductRowBaseModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"砍价列表为空");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -扫一扫获取商品信息
- (RACSignal *)fetchGoodsMsgWithScanCode:(NSString *)scanCode
{
    return [self.client fetchGoodsMsgWithScanCode:scanCode];
}

@end
