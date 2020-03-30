//
//  HomeBargainHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeBargainHeaderView.h"

@implementation HomeBargainHeaderView

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
    // 懒店砍价
    self.leftTipLabel.text = @"懒店砍价";
}

@end
