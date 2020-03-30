//
//  ConfirmOrderListAmountCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListAmountCellViewModel.h"

#import "ConfirmOrderListAmountCell.h"

@implementation ConfirmOrderListAmountCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListAmountCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListAmountCellHeight;
    }
    return self;
}

@end
