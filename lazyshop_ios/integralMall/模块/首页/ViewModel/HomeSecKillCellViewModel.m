//
//  HomeSecKillCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeSecKillCellViewModel.h"

#import "HomeSecKillCell.h"

@implementation HomeSecKillCellViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super initWithItemModels:itemModels]) {
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeSecKillCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeSecKillCell fetchCellHeight];
    }
    return self;
}

@end
