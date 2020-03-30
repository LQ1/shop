//
//  ConfirmOrderListCashbackCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListCashbackCellViewModel.h"

#import "ConfirmOrderListCashbackCell.h"

@implementation ConfirmOrderListCashbackCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListCashbackCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListCashbackCellHeight;
    }
    return self;
}

@end
