//
//  CommentClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentClient.h"

#define API_GET_GOODS_COMMENT   @"http://"APP_DOMAIN@"/goods/comment"
#define API_GET_ORDER_COMMENT   @"http://"APP_DOMAIN@"/user/order/commentdetail"

@implementation CommentClient

#pragma mark -商品评价
- (RACSignal *)getGoodsCommentWithGoods_id:(NSString *)goods_id
{
    goods_id = goods_id?:@"";
    
    NSDictionary *prams = @{
                            @"goods_id":goods_id
                            };
    
    return [LYHttpHelper GET:API_GET_GOODS_COMMENT params:prams dealCode:YES];
}

#pragma mark -订单详情评价
- (RACSignal *)getOrderCommentWithOrder_detail_id:(NSString *)order_detail_id
{
    order_detail_id = order_detail_id?:@"";
    
    NSDictionary *prams = @{
                            @"order_detail_id":order_detail_id,
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper GET:API_GET_ORDER_COMMENT params:prams dealCode:YES];
}

@end
