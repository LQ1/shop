//
//  SettingItemFeedBackView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingItemFeedBackView.h"

@implementation SettingItemFeedBackView

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
    self.titleLabel.text = @"功能反馈";
    
    [self addBottomLine];
}

@end
