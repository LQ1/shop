//
//  LYSectionGrayBarView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYSectionGrayBarView.h"

@implementation LYSectionGrayBarView

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
    UIView *grayView = [UIView new];
    grayView.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
