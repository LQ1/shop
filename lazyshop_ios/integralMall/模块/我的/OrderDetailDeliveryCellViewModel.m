//
//  OrderDetailDeliveryCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailDeliveryCellViewModel.h"

#import "OrderDetailModel.h"
#import "OrderDetailDeliveryCell.h"

@implementation OrderDetailDeliveryCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model
{
    self = [super init];
    if (self) {
        self.delivery_id = model.delivery_id;
        self.delivery_no = model.delivery_no;
        self.delivery_name = model.delivery_name;
        self.UIClassName = NSStringFromClass([OrderDetailDeliveryCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 55;
    }
    return self;
}

@end
