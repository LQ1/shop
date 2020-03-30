//
//  UIView+FillCorner.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "UIView+FillCorner.h"

@implementation UIView (FillCorner)

#pragma mark -补圆角
- (void)lyFillTopCornerWithWidth:(CGFloat)width
                     colorString:(NSString *)color
{
    UIView *leftTopView = [UIView new];
    leftTopView.backgroundColor = [CommUtls colorWithHexString:color];
    [self.superview addSubview:leftTopView];
    [leftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.width.height.mas_equalTo(width);
    }];
    UIView *rightTopView = [UIView new];
    rightTopView.backgroundColor = [CommUtls colorWithHexString:color];
    [self.superview addSubview:rightTopView];
    [rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.width.height.mas_equalTo(width);
    }];
}

- (void)lyFillBottomCornerWithWidth:(CGFloat)width
                        colorString:(NSString *)color
{
    UIView *leftBottomView = [UIView new];
    leftBottomView.backgroundColor = [CommUtls colorWithHexString:color];
    [self.superview addSubview:leftBottomView];
    [leftBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.width.height.mas_equalTo(width);
    }];
    UIView *rightBottomView = [UIView new];
    rightBottomView.backgroundColor = [CommUtls colorWithHexString:color];
    [self.superview addSubview:rightBottomView];
    [rightBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.width.height.mas_equalTo(width);
    }];
}

@end
