//
//  OrderDetailService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailService : NSObject

/*
 *  订单详情
 */
- (RACSignal *)fetchOrderDetailWithOrder_id:(NSString *)order_id;

#pragma mark -申请售后
- (RACSignal *)applyBackWithOrder_detail_id:(NSString *)order_detail_id;

#pragma mark -快递追踪
- (RACSignal *)getDeliverHandleWithDeliver_id:(NSString *)deliver_id
                                  delivery_no:(NSString *)delivery_no;

@end
