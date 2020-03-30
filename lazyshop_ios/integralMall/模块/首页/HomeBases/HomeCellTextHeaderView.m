//
//  HomeCellTextHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeCellTextHeaderView.h"

@implementation HomeCellTextHeaderView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        [self addViews:title];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews:(NSString *)title
{
    // 背景
    self.backgroundColor = [UIColor whiteColor];
    // 懒店精选
    UILabel *titleTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                          textAlignment:NSTextAlignmentCenter
                                              textColor:@"#000000"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:title];
    _titleTipLabel = titleTipLabel;
    [titleTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.center.mas_equalTo(self);
    }];
    // 左线
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [CommUtls colorWithHexString:@"#BBB1B1"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleTipLabel.left).offset(-25);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(1./[UIScreen mainScreen].scale);
        make.centerY.mas_equalTo(self);
    }];
    //
    // 右线
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [CommUtls colorWithHexString:@"#BBB1B1"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleTipLabel.right).offset(25);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1./[UIScreen mainScreen].scale);
        make.centerY.mas_equalTo(self);
    }];
}

@end
