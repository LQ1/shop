//
//  GoodsDetailClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailClient.h"

#define API_GET_GOODS_DETAIL   @"http://"APP_DOMAIN@"/goods/one"
#define API_GET_GOODS_ATTR     @"http://"APP_DOMAIN@"/goods/attr"
#define API_GET_GOODS_SKU      @"http://"APP_DOMAIN@"/goods/sku"
#define API_GET_BARGAIN_JOIN   @"http://"APP_DOMAIN@"/activity/bargain/join"
#define API_BIND_PARTNER       @"http://"APP_DOMAIN@"/partner/user/bind"
#define API_GET_BARGAIN_START  @"http://"APP_DOMAIN@"/activity/bargain/start"
#define API_GET_GROUP_JOIN     @"http://"APP_DOMAIN@"/activity/group/join"

#define API_GET_GOODS_INTRODUCE @"http://"APP_DOMAIN@"/goods/detail"

@implementation GoodsDetailClient

#pragma mark -获取商品详情
- (RACSignal *)getGoodsDetailWithGoodID:(NSInteger)goodID
                               activity:(NSString *)activity
                      activity_flash_id:(NSString *)activity_flash_id
                    activity_bargain_id:(NSString *)activity_bargain_id
                      activity_group_id:(NSString *)activity_group_id
{
    activity = activity?:@"";
    activity_flash_id = activity_flash_id?:@"";
    activity_bargain_id = activity_bargain_id?:@"";
    activity_group_id = activity_group_id?:@"";
    
    NSDictionary *prams = @{
                            @"goods_id":@(goodID),
                            @"activity":activity,
                            @"activity_flash_id":activity_flash_id,
                            @"activity_bargain_id":activity_bargain_id,
                            @"activity_group_id":activity_group_id
                            };

    return [LYHttpHelper GET:API_GET_GOODS_DETAIL params:prams dealCode:YES];
}

#pragma mark -获取商品规格和规格值
- (RACSignal *)fetchGoodsAttrWithGoodID:(NSString *)goods_id
{
    goods_id = goods_id?:@"";

    NSDictionary *prams = @{@"goods_id":goods_id};

    return [LYHttpHelper GET:API_GET_GOODS_ATTR params:prams dealCode:YES];
}

#pragma mark -获取商品sku等
- (RACSignal *)fetchGoodsSkuWithGoodsID:(NSString *)goods_id
{
    goods_id = goods_id?:@"";

    NSDictionary *prams = @{@"goods_id":goods_id};
    
    return [LYHttpHelper GET:API_GET_GOODS_SKU params:prams dealCode:YES];
}

#pragma mark -获取用户是否已参加砍价
- (RACSignal *)fetchGoodsJoinBargain:(NSString *)activity_bargain_id
{
    activity_bargain_id = activity_bargain_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_bargain_id":activity_bargain_id
                            };
    return [LYHttpHelper POST:API_GET_BARGAIN_JOIN params:prams dealCode:YES];
}

#pragma mark - 扫合伙人推荐商品海报二维码 绑定关联合伙人
- (RACSignal *)bindPartnerWithScanQRCode:(NSString*)referee_id {
    NSDictionary *params = @{
                            @"token":SignInToken,
                            @"referee_id":[NSNumber numberWithInt:[referee_id intValue]]
                            };
    
    return  [LYHttpHelper POST:API_BIND_PARTNER params:params dealCode:YES];
}

#pragma mark -发起砍价
- (RACSignal *)startBargain:(NSString *)activity_bargain_id
{
    activity_bargain_id = activity_bargain_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_bargain_id":activity_bargain_id
                            };
    return [LYHttpHelper POST:API_GET_BARGAIN_START params:prams dealCode:YES];
}

#pragma mark -获取用户是否已参加拼团
- (RACSignal *)fetchGoodsJoinGroup:(NSString *)activity_group_id
{
    activity_group_id = activity_group_id?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"activity_bargain_id":activity_group_id
                            };
    
    return [LYHttpHelper POST:API_GET_GROUP_JOIN params:prams dealCode:YES];
}

#pragma mark -获取商品介绍
- (RACSignal *)fetchGoodsIntroduceWithGoods_id:(NSString *)goods_id
{
    goods_id = goods_id?:@"";
    
    NSDictionary *prams = @{
                            @"goods_id":goods_id
                            };
    
    return [LYHttpHelper GET:API_GET_GOODS_INTRODUCE params:prams dealCode:YES];
}


@end
