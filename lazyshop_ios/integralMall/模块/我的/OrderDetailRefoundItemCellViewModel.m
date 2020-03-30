//
//  OrderDetailRoundItemCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailRefoundItemCellViewModel.h"

#import "OrderDetailRefoundItemCell.h"

@implementation OrderDetailRefoundItemCellViewModel

- (instancetype)initWithOrder_detail_id:(NSString *)order_detail_id
{
    self = [super init];
    if (self) {
        self.order_detail_id = order_detail_id;
        self.UIClassName = NSStringFromClass([OrderDetailRefoundItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 44.f;
    }
    return self;
}

@end
