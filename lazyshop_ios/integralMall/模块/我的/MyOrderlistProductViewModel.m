//
//  MyOrderlistProductViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrderlistProductViewModel.h"

#import "MyOrdersItemCell.h"

@implementation MyOrderlistProductViewModel

- (instancetype)initWithModel:(MyOrderItemModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.UIClassName = NSStringFromClass([MyOrdersItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 110.0;
    }
    return self;
}

@end
