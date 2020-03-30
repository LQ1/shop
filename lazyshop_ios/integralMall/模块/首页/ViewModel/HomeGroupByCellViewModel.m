//
//  HomeGroupByCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeGroupByCellViewModel.h"

#import "HomeGroupBuyCell.h"

@implementation HomeGroupByCellViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super initWithItemModels:itemModels]) {
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeGroupBuyCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeGroupBuyCell fetchCellHeight];
    }
    return self;
}

@end
