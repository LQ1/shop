//
//  MyOrdersService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrdersService : NSObject

/*
 *  获取我的订单列表
 */
- (RACSignal *)fetchMyOrdersListWithOrder_status:(NSString *)order_status
                                            page:(NSString *)page;

/*
 *  删除订单
 */
- (RACSignal *)deleteOrderWithOrder_id:(NSString *)order_id;

/*
 *  确认收货
 */
- (RACSignal *)confirmOrderWithOrder_id:(NSString *)order_id;

/*
 *  取消订单
 */
- (RACSignal *)cancelOrderWithOrder_id:(NSString *)order_id;

/*
 *  退款/维修 列表
 */
- (RACSignal *)backListWithPage:(NSString *)page;

@end
