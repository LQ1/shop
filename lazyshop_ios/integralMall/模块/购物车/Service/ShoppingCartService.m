//
//  ShoppingCartService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartService.h"

#import "ShoppingCartClient.h"
#import "ShoppingCartItemModel.h"

@interface ShoppingCartService()

@property (nonatomic,strong) ShoppingCartClient *client;
@property (nonatomic,assign) NSInteger cartGoodsCount;

@end

@implementation ShoppingCartService

#pragma mark -单例

static ShoppingCartService *ccInstance = nil;

+ (ShoppingCartService *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ccInstance                     = [[super allocWithZone:NULL] init];
        ccInstance.client              = [ShoppingCartClient new];
    });
    
    return ccInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [ShoppingCartService sharedInstance];
}

+ (id)copy
{
    return [ShoppingCartService sharedInstance];
}

#pragma mark -添加储值商品到购物车
- (RACSignal *)addGoodsToCartWithGoods_id:(NSString *)goods_id
                             goods_sku_id:(NSString *)goods_sku_id
                                 quantity:(NSString *)quantity
{
    @weakify(self);
    return [[self.client addGoodsToCartWithGoods_id:goods_id
                                      goods_sku_id:goods_sku_id
                                          quantity:quantity] map:^id(id value) {
        @strongify(self);
        [self getCartGoodsQuantity];
        return @(YES);
    }];
}

#pragma mark -获取购物车列表
- (RACSignal *)fetchCartList
{
    @weakify(self);
    return [[self.client fetchCartList] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        @strongify(self);
        [self getCartGoodsQuantity];
        NSArray *resultArray = [ShoppingCartItemModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

#pragma mark -删除购物车商品
- (RACSignal *)deleteCartGoodsWithGoods_cart_ids:(NSString *)goods_cart_ids
{
    @weakify(self);
    return [[self.client deleteCartGoodsWithGoods_cart_ids:goods_cart_ids] map:^id(id value) {
        @strongify(self);
        [self getCartGoodsQuantity];
        return @(YES);
    }];
}

/*
 *  更新购物车商品数量
 */
- (RACSignal *)updateCartGoodsQuantityWithGoods_cart_id:(NSString *)goods_cart_id
                                               quantity:(NSString *)quantity
{
    @weakify(self);
    return [[self.client updateCartGoodsQuantityWithGoods_cart_id:goods_cart_id
                                                        quantity:quantity] map:^id(id value) {
        @strongify(self);
        [self getCartGoodsQuantity];
        return @(YES);
    }];
}

/*
 *  获取购物车商品数量
 */
- (void)getCartGoodsQuantity
{
    @weakify(self);
    [[self.client getCartGoodsQuantity] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.cartGoodsCount = [dict[@"data"][@"total_quantity"] integerValue];
    } error:^(NSError *error) {
        CLog(@"获取购物车数量失败:%@",error);
    }];
}

/*
 *  清除购物车商品数量
 */
- (void)clearCartGoodsQuantity
{
    self.cartGoodsCount = 0;
}

@end
