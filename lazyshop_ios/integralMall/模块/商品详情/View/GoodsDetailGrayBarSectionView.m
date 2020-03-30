//
//  GoodsDetailGrayBarSectionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailGrayBarSectionView.h"

@implementation GoodsDetailGrayBarSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    UIView *view = [UIView new];
    view.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
