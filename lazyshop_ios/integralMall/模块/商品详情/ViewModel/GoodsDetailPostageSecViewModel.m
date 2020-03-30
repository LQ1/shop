//
//  GoodsDetailPostageSecViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPostageSecViewModel.h"

#import "GoodsDetailPostageViewModel.h"
#import "GoodsDetailGrayBarSectionView.h"

@implementation GoodsDetailPostageSecViewModel

- (instancetype)initWithGoodsDetailPostageViewModel:(GoodsDetailPostageViewModel *)postageViewModel
{
    self = [super init];
    if (self) {
        self.childViewModels = @[postageViewModel];
        self.UIClassName = NSStringFromClass([GoodsDetailGrayBarSectionView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = GoodsDetailGrayBarSectionViewHeight;
    }
    return self;
}

@end
