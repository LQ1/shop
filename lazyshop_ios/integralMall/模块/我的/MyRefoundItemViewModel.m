//
//  MyRefoundItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyRefoundItemViewModel.h"

#import "MyOrdersRefoundFooter.h"
#import "MyOrderlistProductViewModel.h"

@implementation MyRefoundItemViewModel

- (instancetype)initWithModel:(MyRefoundItemModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.UIClassName = NSStringFromClass([MyOrdersRefoundFooter class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = MyOrdersRefoundFooterHeight;
        
        MyOrderItemModel *orderModel = [MyOrderItemModel new];
        orderModel.quantity = model.quantity;
        orderModel.goods_thumb = model.goods_thumb;
        orderModel.order_type = model.order_type;
        orderModel.goods_title = model.goods_title;
        orderModel.price = model.price;
        orderModel.order_detail_id = model.order_detail_id;
        orderModel.score = model.score;
        orderModel.attr_values = model.attr_values;

        MyOrderlistProductViewModel *itemVM = [[MyOrderlistProductViewModel alloc] initWithModel:orderModel];
        self.childViewModels = @[itemVM];
    }
    return self;
}

@end
