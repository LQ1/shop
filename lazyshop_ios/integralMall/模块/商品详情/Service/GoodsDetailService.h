//
//  GoodsDetailService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailService : NSObject

/*
 *  商品详情
 */
- (RACSignal *)getGoodsDetailWithGoodID:(NSInteger)goodID
                               activity:(NSString *)activity
                      activity_flash_id:(NSString *)activity_flash_id
                    activity_bargain_id:(NSString *)activity_bargain_id
                      activity_group_id:(NSString *)activity_group_id;
/*
 *  商品规格
 */
- (RACSignal *)fetchGoodsAttrWithGoodID:(NSString *)goods_id;

/**
 *  扫合伙人推荐商品海报二维码 绑定关联合伙人
 */
- (RACSignal *)bindPartnerWithScanQRCode:(NSString*)referee_id;

/*
 *  商品sku
 */
- (RACSignal *)fetchGoodsSkuWithGoodsID:(NSString *)goods_id;

/*
 *  是否参加砍价
 */
- (RACSignal *)fetchGoodsJoinBargain:(NSString *)activity_bargain_id;

#pragma mark -发起砍价
- (RACSignal *)startBargain:(NSString *)activity_bargain_id;

/*
 *  是否参与拼团
 */
- (RACSignal *)fetchGoodsJoinGroup:(NSString *)activity_group_id;

#pragma mark -获取商品介绍
- (RACSignal *)fetchGoodsIntroduceWithGoods_id:(NSString *)goods_id;

@end
