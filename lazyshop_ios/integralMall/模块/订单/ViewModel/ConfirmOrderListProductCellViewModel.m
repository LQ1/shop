//
//  ConfirmOrderListProductCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListProductCellViewModel.h"

#import "ConfirmOrderListProductCell.h"

@implementation ConfirmOrderListProductCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListProductCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListProductCellHeight;
    }
    return self;
}

@end
