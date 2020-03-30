//
//  MyOrdersService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersService.h"

#import "MyOrdersClient.h"
#import "MyOrderModel.h"
#import "MyRefoundItemModel.h"

@interface MyOrdersService()

@property (nonatomic, strong) MyOrdersClient *client;

@end

@implementation MyOrdersService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [MyOrdersClient new];
    }
    return self;
}

#pragma mark -我的订单列表
- (RACSignal *)fetchMyOrdersListWithOrder_status:(NSString *)order_status
                                            page:(NSString *)page
{
    return [[self.client fetchMyOrdersListWithOrder_status:order_status page:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *oldArray = dict[@"data"];
        // 数据处理
        NSMutableArray *newArray = [NSMutableArray array];
        [oldArray enumerateObjectsUsingBlock:^(NSDictionary *itemDict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *orderDict = [NSMutableDictionary dictionaryWithDictionary:itemDict[@"order"]];
            [orderDict setObject:itemDict[@"order_detail"] forKey:@"order_detail"];
            [newArray addObject:orderDict];
        }];
        
        NSArray *resultArray = [MyOrderModel modelsFromJSONArray:newArray];
        [resultArray enumerateObjectsUsingBlock:^(MyOrderModel *orderModel, NSUInteger idx, BOOL * _Nonnull stop) {
            orderModel.order_detail = [MyOrderItemModel modelsFromJSONArray:orderModel.order_detail];
            [orderModel.order_detail enumerateObjectsUsingBlock:^(MyOrderItemModel *detailItemModel, NSUInteger idx, BOOL * _Nonnull stop) {
                detailItemModel.order_type = orderModel.order_type;
            }];
        }];
        
        return resultArray;
    }];
}

/*
 *  删除订单
 */
- (RACSignal *)deleteOrderWithOrder_id:(NSString *)order_id
{
    return [[self.client deleteOrderWithOrder_id:order_id] map:^id(id value) {
        return @(YES);
    }];
}

/*
 *  确认收货
 */
- (RACSignal *)confirmOrderWithOrder_id:(NSString *)order_id
{
    return [[self.client confirmOrderWithOrder_id:order_id] map:^id(id value) {
        return @(YES);
    }];
}

/*
 *  取消订单
 */
- (RACSignal *)cancelOrderWithOrder_id:(NSString *)order_id
{
    return [[self.client cancelOrderWithOrder_id:order_id] map:^id(id value) {
        return @(YES);
    }];
}

/*
 *  退款/维修 列表
 */
- (RACSignal *)backListWithPage:(NSString *)page
{
    return [[self.client backListWithPage:page] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [MyRefoundItemModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"无此类订单");
            return nil;
        }
        return resultArray;
    }];
}

@end
