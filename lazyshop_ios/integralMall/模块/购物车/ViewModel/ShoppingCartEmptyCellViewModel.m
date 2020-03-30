//
//  ShoppingCartEmptyCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartEmptyCellViewModel.h"

#import "ShoppingCartEmptyCell.h"

@implementation ShoppingCartEmptyCellViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ShoppingCartEmptyCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 250.f;
    }
    return self;
}

@end
