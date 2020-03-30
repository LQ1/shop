//
//  ShoppingCartItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartItemViewModel.h"

#import "ShoppingCartItemCell.h"

@implementation ShoppingCartItemViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([ShoppingCartItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 110.0f;
    }
    return self;
}

@end
