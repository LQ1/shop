//
//  ConfirmDetailGapCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailGapCellViewModel.h"

#import "OrderDetailGapCell.h"

@implementation OrderDetailGapCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([OrderDetailGapCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 7.5f;
    }
    return self;
}

@end
