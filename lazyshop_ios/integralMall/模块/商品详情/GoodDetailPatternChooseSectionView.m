//
//  GoodDetailPatternChooseSectionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseSectionView.h"

@interface GoodDetailPatternChooseSectionView()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation GoodDetailPatternChooseSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 标题
    self.titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#666666"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
