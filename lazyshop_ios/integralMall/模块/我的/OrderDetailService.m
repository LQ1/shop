//
//  OrderDetailService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailService.h"

#import "OrderDetailClient.h"
#import "OrderDetailModel.h"

#import "DeliveryModel.h"

@interface OrderDetailService()

@property (nonatomic,strong)OrderDetailClient *client;

@end

@implementation OrderDetailService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [OrderDetailClient new];
    }
    return self;
}

#pragma mark -订单详情
- (RACSignal *)fetchOrderDetailWithOrder_id:(NSString *)order_id
{
    return [[self.client fetchOrderDetailWithOrder_id:order_id] map:^id(NSDictionary *dict) {
        OrderDetailModel *detailModel = [OrderDetailModel modelFromJSONDictionary:dict[@"data"]];
        detailModel.order_detail = [OrderDetailGoodsModel modelsFromJSONArray:detailModel.order_detail];
        [detailModel.order_detail enumerateObjectsUsingBlock:^(OrderDetailGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.order_type = detailModel.order_type;
        }];
        return detailModel;
    }];
}

#pragma mark -申请售后
- (RACSignal *)applyBackWithOrder_detail_id:(NSString *)order_detail_id
{
    return [[self.client applyBackWithOrder_detail_id:order_detail_id] map:^id(NSDictionary *dict) {
        return dict[@"data"][@"service_phone"];
    }];
}

#pragma mark -快递追踪
- (RACSignal *)getDeliverHandleWithDeliver_id:(NSString *)deliver_id
                                  delivery_no:(NSString *)delivery_no
{
    return [[self.client getDeliverHandleWithDeliver_id:deliver_id
                                           delivery_no:delivery_no] map:^id(NSDictionary *dict) {
        DeliveryModel *model = [DeliveryModel modelFromJSONDictionary:dict[@"data"]];
        model.traces = [DeliveryTrackModel modelsFromJSONArray:model.traces];
        return model;
    }];
}

@end
