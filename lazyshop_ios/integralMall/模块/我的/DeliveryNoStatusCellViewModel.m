//
//  DeliveryNoStatusCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryNoStatusCellViewModel.h"

#import "DeliveryNoStatusCell.h"

@implementation DeliveryNoStatusCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([DeliveryNoStatusCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 45.0f;
    }
    return self;
}

@end
