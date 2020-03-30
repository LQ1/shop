//
//  CashBackItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackItemViewModel.h"

#import "CashBackItemCell.h"

@implementation CashBackItemViewModel

- (CGFloat)cellHeight
{
    if (self.isHistoryItem) {
        return CashBackItemCellHeight;
    }
    return CashBackItemCellUpHeight;
}

@end
