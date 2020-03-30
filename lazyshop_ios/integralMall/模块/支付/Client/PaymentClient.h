//
//  PaymentClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentClient : NSObject

/*
 *  储值商品下单
 */
- (RACSignal *)createMoneyOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                 user_coupon_id:(NSString *)user_coupon_id
                                  goods_cart_id:(NSString *)goods_cart_id
                                        postage:(NSString *)postage
                                user_address_id:(NSString *)user_address_id
                                  storehouse_id:(NSString *)storehouse_id
                                    reffer_id:(NSString*)reffer_id;
/*
 *  拼团商品下单
 */
- (RACSignal *)createGroupOrderWithActivity_group_id:(NSString *)activity_group_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id;
/*
 *  秒杀商品下单
 */
- (RACSignal *)createFlashOrderWithActivity_flash_id:(NSString *)activity_flash_id
                                            quantity:(NSString *)quantity
                                     user_address_id:(NSString *)user_address_id
                                       storehouse_id:(NSString *)storehouse_id;
/*
 *  积分商品下单
 */
- (RACSignal *)createScoreOrderWithGoods_sku_id:(NSString *)goods_sku_id
                                       quantity:(NSString *)quantity
                                user_address_id:(NSString *)user_address_id
                                        postage:(NSString *)postage
                                  storehouse_id:(NSString *)storehouse_id;

/*
 *  砍价商品下单
 */
- (RACSignal *)createBargainOrderWithActivity_bargain_id:(NSString *)activity_bargain_id
                                         bargain_open_id:(NSString *)bargain_open_id
                                                quantity:(NSString *)quantity
                                         user_address_id:(NSString *)user_address_id
                                           storehouse_id:(NSString *)storehouse_id;

/*
 *  获取支付宝签名
 */
- (RACSignal *)fetchAliPayOrderStringWithOrderID:(NSString *)orderID;
/*
 *  获取微信支付签名
 */
- (RACSignal *)fetchWXPayOrderStringWithOrderID:(NSString *)orderID;
/*
 *  获取银联支付签名
 */
- (RACSignal *)fetchUnionPayOrderStringWithOrderID:(NSString *)orderID;

#pragma mark -到店支付
- (RACSignal *)shopPayWithOrderID:(NSString *)orderID;

@end
