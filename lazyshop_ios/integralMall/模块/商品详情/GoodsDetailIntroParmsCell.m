//
//  GoodsDetailIntroParmsCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroParmsCell.h"

#import "GoodsDetailIntroParmsCellViewModel.h"

@interface GoodsDetailIntroParmsCell()

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UILabel *parmNameLabel;
@property (nonatomic,strong) UILabel *parmValueLabel;

@end

@implementation GoodsDetailIntroParmsCell

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
    // 左线
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
    [self.contentView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(1);
        make.top.bottom.mas_equalTo(0);
    }];
    // 右线
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
    [self.contentView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(1);
        make.top.bottom.mas_equalTo(0);
    }];
    // 上线
    UIView *topLine = [UIView new];
    self.topLine = topLine;
    topLine.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(leftLine.right);
        make.right.mas_equalTo(rightLine.left);
        make.height.mas_equalTo(1);
    }];
    // 下线
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(leftLine.right);
        make.right.mas_equalTo(rightLine.left);
        make.height.mas_equalTo(1);
    }];
    
    // 参数名称
    self.parmNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#666666"
                                                   adjustsWidth:YES
                                                   cornerRadius:0
                                                           text:nil];
    [self.parmNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLine.right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(90);
    }];
    // 中间线
    UIView *midLine = [UIView new];
    midLine.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
    [self.contentView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomLine.top);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.parmNameLabel.right).offset(5);
    }];
    // 参数值
    self.parmValueLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                   textAlignment:0
                                                       textColor:@"#666666"
                                                    adjustsWidth:NO
                                                    cornerRadius:0
                                                            text:nil];
    self.parmValueLabel.numberOfLines = 0;
    [self.parmValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(midLine.right).offset(10);
        make.right.mas_equalTo(rightLine.left).offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(GoodsDetailIntroParmsCellViewModel *)vm
{
    self.parmNameLabel.text = vm.param_name;
    self.parmValueLabel.text = vm.param_value;
    self.topLine.hidden = !vm.showTopLine;
}

@end
