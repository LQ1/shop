//
//  SettingItemLawView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingItemLawView.h"

@implementation SettingItemLawView

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
    self.titleLabel.text = @"法律条款";
    
    [self addBottomLine];
}

@end
