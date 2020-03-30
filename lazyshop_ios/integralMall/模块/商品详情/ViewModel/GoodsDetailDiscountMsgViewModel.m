//
//  GoodsDetailDiscountMsgViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailDiscountMsgViewModel.h"

#import "GoodsDetailGrayBarSectionView.h"

@implementation GoodsDetailDiscountMsgViewModel

- (instancetype)initWithItemViewModels:(NSArray *)itemVMs
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([GoodsDetailGrayBarSectionView class]);
        self.UIHeight = GoodsDetailGrayBarSectionViewHeight;
        self.UIReuseID = self.UIClassName;
        self.childViewModels = itemVMs;
    }
    return self;
}

@end
