//
//  HomeScoreScrollItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeScoreScrollItemCell.h"

#import "HomeScoreScrollItemModel.h"

@interface HomeScoreScrollItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeScoreScrollItemCell

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
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(111);
    }];
    self.titleLabel = [self.shadowView addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#333333"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.right).offset(15);
        make.top.mas_equalTo(22);
        make.right.mas_equalTo(-3);
    }];
}

#pragma mark -reload
- (void)reloadDataWithModel:(HomeScoreScrollItemModel *)itemModel
{
    self.titleLabel.text = itemModel.cat_title;
    [self.imageView ly_showMinImg:itemModel.goods_cat_thumb];
}

@end
