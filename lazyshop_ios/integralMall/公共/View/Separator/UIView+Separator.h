//
//  UIView+Separator.h
//  MobileClassPhone
//
//  Created by Bryce on 14/12/20.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Separator)

- (UIView *)addTopLine;
- (UIView *)addTopLineWithColorString:(NSString *)colorString;
- (UIView *)addTopLineWithColor:(UIColor *)color height:(CGFloat)height padding:(UIEdgeInsets)padding;
//! 添加一个灰色的底部边线
- (UIView *)addBottomLine;
- (UIView *)addBottomLineWithColorString:(NSString *)colorString;
//! 自定义添加一个底部边线
- (UIView *)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height padding:(UIEdgeInsets)padding;
//! 添加左边距15的线
- (UIView *)addBottomLineWithDefaultPaddingLeft;

/**
 添加左右边距15的线
 */
- (void)addBottomLR:(UIColor *)color;

- (UIView *)addLeftLineWithColorString:(NSString *)colorString;

@end
