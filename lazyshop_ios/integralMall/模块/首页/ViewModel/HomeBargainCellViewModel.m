//
//  HomeBargainCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeBargainCellViewModel.h"

#import "HomeBargainCell.h"

@implementation HomeBargainCellViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super initWithItemModels:itemModels]) {
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeBargainCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeBargainCell fetchCellHeight];
    }
    return self;
}

@end
