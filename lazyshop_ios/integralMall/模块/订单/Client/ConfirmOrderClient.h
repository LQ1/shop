//
//  ConfirmOrderClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfirmOrderClient : NSObject

/*
 *  储值商品确认下单
 */
- (RACSignal *)confirmOrderWithConfirm_order_from:(NSString *)confirm_order_from
                                    goods_cart_id:(NSString *)goods_cart_id
                                         goods_id:(NSString *)goods_id
                                     goods_sku_id:(NSString *)goods_sku_id
                                         quantity:(NSString *)quantity;
/*
 *  拼团商品确认下单
 */
- (RACSignal *)confirmGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                             quantity:(NSString *)quantity;
/*
 *  秒杀商品确认下单
 */
- (RACSignal *)confirmFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                             quantity:(NSString *)quantity;
/*
 *  积分商品确认下单
 */
- (RACSignal *)confirmScoreOrderWithGoods_id:(NSString *)goods_id
                                goods_sku_id:(NSString *)goods_sku_id
                                    quantity:(NSString *)quantity;

#pragma mark -砍价商品确认下单
- (RACSignal *)confirmBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                          bargain_open_id:(NSString *)bargain_open_id;

@end
