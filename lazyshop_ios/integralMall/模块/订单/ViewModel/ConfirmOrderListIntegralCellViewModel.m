//
//  ConfirmOrderListIntegralCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListIntegralCellViewModel.h"

#import "ConfirmOrderListIntegralCell.h"

@implementation ConfirmOrderListIntegralCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListIntegralCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListIntegralCellHeight;
    }
    return self;
}

@end
