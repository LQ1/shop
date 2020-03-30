//
//  CategoryRightItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryRightItemCell.h"

#import "CategoryThirdItemViewModel.h"
#import "CategoryViewMacro.h"

@interface CategoryRightItemCell()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation CategoryRightItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 图
    self.imageView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:0];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CategoryRightItemImageWidth);
        make.height.mas_equalTo(CategoryRightItemImageHeight);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(0);
    }];
    // 文
    self.titleLabel = [self.contentView addLabelWithFontSize:MIN_FONT_SIZE
                                               textAlignment:NSTextAlignmentCenter
                                                   textColor:@"#333333"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.bottom).offset(CategoryRightItemTitleTopGap);
        make.height.mas_equalTo(CategoryRightItemTitleHeight);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)reloadDataWithViewModel:(CategoryThirdItemViewModel *)viewModel
{
    [self.imageView ly_showMinImg:viewModel.imgUrl];
    self.titleLabel.text = viewModel.thirdCategoryName;
}

@end
