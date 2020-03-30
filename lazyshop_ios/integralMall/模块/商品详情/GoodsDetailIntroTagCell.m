//
//  GoodsDetailIntroTagCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroTagCell.h"

#import "GoodsDetailIntroTagCellViewModel.h"

@interface GoodsDetailIntroTagCell()

@property (nonatomic,strong)UILabel *tagNameLabel;
@property (nonatomic,strong)UILabel *tagValueLabel;

@end

@implementation GoodsDetailIntroTagCell

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
    // 名称
    self.tagNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:NSTextAlignmentCenter
                                         textColor:@"#656565"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:nil];
    [self.tagNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(60);
    }];
    
    // 左线
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(self.tagNameLabel.left).offset(-20);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.tagNameLabel);
    }];
    
    // 右线
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(self.tagNameLabel.right).offset(20);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.tagNameLabel);
    }];
    
    // 文字
    self.tagValueLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#656565"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    self.tagValueLabel.numberOfLines = 0;
    [self.tagValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.tagNameLabel.bottom).offset(16);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(GoodsDetailIntroTagCellViewModel *)vm
{
    self.tagNameLabel.text = vm.tagName;
    self.tagValueLabel.text = vm.tagValue;
}

@end
