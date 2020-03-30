//
//  UIView+Separator.m
//  MobileClassPhone
//
//  Created by Bryce on 14/12/20.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import "UIView+Separator.h"

@implementation UIView (Separator)

- (UIView *)addTopLine
{
    UIColor *color = [CommUtls colorWithHexString:APP_GapColor];
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;
    UIEdgeInsets padding = UIEdgeInsetsZero;
    return [self addTopLineWithColor:color height:lineHeight padding:padding];
}

- (UIView *)addTopLineWithColorString:(NSString *)colorString
{
    UIColor *color;
    if (!colorString.length) {
        color = [CommUtls colorWithHexString:APP_GapColor];
    }else{
        color = [CommUtls colorWithHexString:colorString];
    }
    
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;
    UIEdgeInsets padding = UIEdgeInsetsZero;
    return [self addTopLineWithColor:color height:lineHeight padding:padding];
}

- (UIView *)addBottomLine
{
    UIColor *color = [CommUtls colorWithHexString:@"#eeeeee"];
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;
    UIEdgeInsets padding = UIEdgeInsetsZero;
    return [self addBottomLineWithColor:color height:lineHeight padding:padding];
}

- (UIView *)addBottomLineWithColorString:(NSString *)colorString
{
    UIColor *color;
    if (!colorString.length) {
        color = [CommUtls colorWithHexString:APP_GapColor];
    }else{
        color = [CommUtls colorWithHexString:colorString];
    }
    
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;
    UIEdgeInsets padding = UIEdgeInsetsZero;
    return [self addBottomLineWithColor:color height:lineHeight padding:padding];
}

- (UIView *)addTopLineWithColor:(UIColor *)color height:(CGFloat)height padding:(UIEdgeInsets)padding
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self addSubview:line];

    @weakify(self);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
         make.left.equalTo(self.left).offset(padding.left);
         make.right.equalTo(self.right).offset(-padding.right);
         make.top.equalTo(self.top);
         make.height.equalTo(height);
     }];
    return line;
}

- (UIView *)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height padding:(UIEdgeInsets)padding
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self addSubview:line];

    @weakify(self);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
         make.left.equalTo(self.left).offset(padding.left);
         make.right.equalTo(self.right).offset(-padding.right);
         make.bottom.equalTo(self.bottom);
         make.height.equalTo(height);
     }];

    return line;
}

- (UIView *)addBottomLineWithDefaultPaddingLeft
{
    UIColor *color = [CommUtls colorWithHexString:APP_GapColor];
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 15, 0, 0);
    return [self addBottomLineWithColor:color height:lineHeight padding:padding];
}

- (void)addBottomLR:(UIColor *)color {
    [self addBottomLineWithColor:color
                          height:1./[UIScreen mainScreen].scale
                         padding:UIEdgeInsetsMake(0, 15, 0, 15)];
}

- (UIView *)addLeftLineWithColorString:(NSString *)colorString
{
    UIColor *color;
    if (!colorString.length) {
        color = [CommUtls colorWithHexString:APP_GapColor];
    }else{
        color = [CommUtls colorWithHexString:colorString];
    }
    
    CGFloat lineHeight = 1./[UIScreen mainScreen].scale;

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(lineHeight);
    }];
    return line;
}

@end
