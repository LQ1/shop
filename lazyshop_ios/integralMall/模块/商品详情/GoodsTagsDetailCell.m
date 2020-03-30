//
//  GoodsTagsDetailCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/13.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsTagsDetailCell.h"

#import "GoodsTagModel.h"

@interface GoodsTagsDetailCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;

@end

@implementation GoodsTagsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 标题
    self.titleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#333333"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12.5);
    }];
    // 详情
    self.detailLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                textAlignment:0
                                                    textColor:@"#999999"
                                                 adjustsWidth:NO
                                                 cornerRadius:0
                                                         text:nil];
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLabel.bottom).offset(7);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(GoodsTagModel *)model
{
    self.titleLabel.text = model.goods_tag_title;
    self.detailLabel.text = model.goods_tag_content;
}

#pragma mark -height
+ (CGFloat)cellHeight:(GoodsTagModel *)model;
{
    CGFloat height = 47+[CommUtls getContentSize:model.goods_tag_content
                                            font:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                            size:CGSizeMake(KScreenWidth-30, CGFLOAT_MAX)].height;
    return height;
}

@end
