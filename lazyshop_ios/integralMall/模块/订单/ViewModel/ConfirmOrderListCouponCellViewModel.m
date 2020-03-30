//
//  ConfirmOrderListCouponCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListCouponCellViewModel.h"

#import "ConfirmOrderListCouponCell.h"

@implementation ConfirmOrderListCouponCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListCouponCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListCouponCellHeight;
    }
    return self;
}

@end
