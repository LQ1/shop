//
//  ShoppingCartSecViewMdoel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartSecViewMdoel.h"

#import "LYSectionGrayBarView.h"

@implementation ShoppingCartSecViewMdoel

- (instancetype)initWithHeight:(CGFloat)height
               childViewModels:(NSArray *)childViewModels
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([LYSectionGrayBarView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = height;
        self.childViewModels = [NSArray arrayWithArray:childViewModels];
    }
    return self;
}

@end
