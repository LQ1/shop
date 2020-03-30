//
//  ShoppingCartService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartService : NSObject

@property (nonatomic,readonly) NSInteger cartGoodsCount;

/*
 *  单例
 */
+ (ShoppingCartService *)sharedInstance;

/*
 *  储值商品添加购物车
 */
- (RACSignal *)addGoodsToCartWithGoods_id:(NSString *)goods_id
                             goods_sku_id:(NSString *)goods_sku_id
                                 quantity:(NSString *)quantity;

/*
 *  获取购物车列表
 */
- (RACSignal *)fetchCartList;

/*
 *  删除购物车商品
 */
- (RACSignal *)deleteCartGoodsWithGoods_cart_ids:(NSString *)goods_cart_ids;

/*
 *  更新购物车商品数量
 */
- (RACSignal *)updateCartGoodsQuantityWithGoods_cart_id:(NSString *)goods_cart_id
                                               quantity:(NSString *)quantity;

/*
 *  获取购物车商品数量
 */
- (void)getCartGoodsQuantity;

/*
 *  清除购物车商品数量
 */
- (void)clearCartGoodsQuantity;

@end
