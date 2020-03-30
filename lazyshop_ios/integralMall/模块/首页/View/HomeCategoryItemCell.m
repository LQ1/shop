//
//  HomeCategoryItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeCategoryItemCell.h"

#import "HomeCategoryMacro.h"
#import "HomeCategoryItemModel.h"

@interface HomeCategoryItemCell()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation HomeCategoryItemCell

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
    UIView *imgContentView = [UIView new];
    [self.contentView addSubview:imgContentView];
    [imgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HomeCategoryItemImageContentWidth);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    UIImageView *imageView = [UIImageView new];
    self.imageView = imageView;
    [imgContentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(imgContentView);
        make.width.height.mas_equalTo(HomeCategoryItemImageWidth);
    }];
    
    // 标题
    UILabel *titleLabel = [UILabel new];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(imageView.bottom).offset(HomeCategoryItemMidGap);
        make.height.mas_equalTo(HomeCategoryItemTitleHeight);
    }];
}

- (void)reloadDataWithModel:(HomeCategoryItemModel *)itemModel
{
    [self.imageView ly_showMinImg:itemModel.icon];
    self.titleLabel.text = itemModel.goods_cat_name;
}

@end
