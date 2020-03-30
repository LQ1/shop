//
//  RelateScoreClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelateScoreClient : NSObject

#pragma mark -我的店铺列表
- (RACSignal *)getMyScoreList;

#pragma mark -我的店铺详情
- (RACSignal *)getMyScoreDetailWithShop_id:(NSString *)shop_id;

#pragma mark -待关联店铺详情
- (RACSignal *)relateShopDetailWithShop_id:(NSString *)shop_id;

#pragma mark -绑定店铺
- (RACSignal *)bindScoreWithShop_id:(NSString *)shop_id;

#pragma mark -返利绑定已关联店铺
- (RACSignal *)bindRebateScoreWithShop_id:(NSString *)shop_id
                          order_detail_id:(NSString *)order_detail_id;

@end
