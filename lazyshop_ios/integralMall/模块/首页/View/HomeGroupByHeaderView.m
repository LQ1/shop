//
//  HomeGroupByHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeGroupByHeaderView.h"

@implementation HomeGroupByHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 懒店拼团
    self.leftTipLabel.text = @"懒店拼团";
}

@end
