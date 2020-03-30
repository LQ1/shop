//
//  GoodsDetailTagCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailTagCell.h"

@interface GoodsDetailTagCell()

@property (nonatomic,strong)UILabel *tipLabel;

@end

@implementation GoodsDetailTagCell

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
    // 图
    UIImageView *tipView = [self.contentView addImageViewWithImageName:@"详情页说明图标"
                                                          cornerRadius:0];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(13.5);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(0);
    }];
    // 文
    self.tipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                             textAlignment:0
                                                 textColor:@"#80838d"
                                              adjustsWidth:YES
                                              cornerRadius:0
                                                      text:nil];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipView.right).offset(5);
        make.right.mas_equalTo(-5);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)reloadTitle:(NSString *)title
{
    self.tipLabel.text = title;
}

@end
