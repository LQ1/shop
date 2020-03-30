//
//  ConfirmOrderListWareHouseCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListWareHouseCellViewModel.h"

#import "ConfirmOrderListWareHouseCell.h"

@implementation ConfirmOrderListWareHouseCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ConfirmOrderListWareHouseCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = ConfirmOrderListWareHouseCellHeight;
    }
    return self;
}

@end
