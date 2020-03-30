//
//  ConfirmOrderListShippingCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListShippingCellViewModel.h"

#import "ConfirmOrderListShippingCell.h"

@implementation ConfirmOrderListShippingCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListShippingCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListShippingCellHeight;
    }
    return self;
}

@end
