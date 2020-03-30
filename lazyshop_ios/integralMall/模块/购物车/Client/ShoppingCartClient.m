//
//  ShoppingCartClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartClient.h"

#define API_SHOPPING_CART_ADD @"http://"APP_DOMAIN@"/goods/cart/add"
#define API_SHOPPING_CART_LIST @"http://"APP_DOMAIN@"/goods/cart/list"
#define API_SHOPPING_CART_DELETE @"http://"APP_DOMAIN@"/goods/cart/delete"
#define API_SHOPPING_CART_UP_QUANTITY @"http://"APP_DOMAIN@"/goods/cart/update"
#define API_SHOPPING_CART_QUANTITY @"http://"APP_DOMAIN@"/goods/cart/goodscount"

@implementation ShoppingCartClient

#pragma mark -添加储值商品到购物车
- (RACSignal *)addGoodsToCartWithGoods_id:(NSString *)goods_id
                             goods_sku_id:(NSString *)goods_sku_id
                                 quantity:(NSString *)quantity
{
    goods_id = goods_id?:@"";
    goods_sku_id = goods_sku_id?:@"";
    quantity = quantity?:@"";
    
    NSDictionary *prams = @{
                            @"goods_id":goods_id,
                            @"goods_sku_id":goods_sku_id,
                            @"quantity":quantity,
                            @"token":SignInToken
                            };
    return [LYHttpHelper POST:API_SHOPPING_CART_ADD params:prams dealCode:YES];
}

#pragma mark -获取购物车列表
- (RACSignal *)fetchCartList
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    return [LYHttpHelper GET:API_SHOPPING_CART_LIST params:prams dealCode:YES];
}

#pragma mark -删除购物车商品
- (RACSignal *)deleteCartGoodsWithGoods_cart_ids:(NSString *)goods_cart_ids
{
    goods_cart_ids = goods_cart_ids?:@"";
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"goods_cart_id":goods_cart_ids
                            };
    
    return [LYHttpHelper POST:API_SHOPPING_CART_DELETE params:prams dealCode:YES];
}

#pragma mark -更新购物车商品数量
- (RACSignal *)updateCartGoodsQuantityWithGoods_cart_id:(NSString *)goods_cart_id
                                               quantity:(NSString *)quantity
{
    goods_cart_id = goods_cart_id?:@"";
    quantity = quantity?:@"";

    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"goods_cart_id":goods_cart_id,
                            @"quantity":quantity
                            };
    
    return [LYHttpHelper POST:API_SHOPPING_CART_UP_QUANTITY params:prams dealCode:YES];
}

#pragma mark -获取购物车商品数量
- (RACSignal *)getCartGoodsQuantity
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_SHOPPING_CART_QUANTITY params:prams dealCode:YES];
}


@end
