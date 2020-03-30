//
//  CategoryRightHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryRightHeaderView.h"

#import "CategorySecondItemViewModel.h"

@interface CategoryRightHeaderView()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation CategoryRightHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 背景
    UIView *backView = [UIView new];
    backView.backgroundColor = [CommUtls colorWithHexString:@"#F5F5F5"];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 标题
    self.titleLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                   textAlignment:0
                                       textColor:@"#333333"
                                    adjustsWidth:NO
                                    cornerRadius:0
                                            text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.top.bottom.mas_equalTo(0);
    }];
}

- (void)reloadDataWithViewModel:(CategorySecondItemViewModel *)viewModel
{
    self.titleLabel.text = viewModel.secondCategoryName;
}

@end
