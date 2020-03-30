//
//  DeliveryHeaderCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryHeaderCellViewModel.h"

#import "DeliveryHeaderCell.h"

@implementation DeliveryHeaderCellViewModel

- (instancetype)initWithDelivery_no:(NSString *)delivery_no
                      delivery_name:(NSString *)delivery_name
{
    self = [super init];
    if (self) {
        self.delivery_no = delivery_no;
        self.delivery_name = delivery_name;
        self.UIClassName = NSStringFromClass([DeliveryHeaderCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 69.0f;
    }
    return self;
}

@end
