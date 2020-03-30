//
//  UIView+Frame.m
//  Sinfo
//
//  Created by xiaoyu on 16/6/29.
//  Copyright © 2016年 YaoZhong. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)lyLeft
{
    return self.frame.origin.x;
}

- (void)setLyLeft:(CGFloat)lyLeft
{
    CGRect frame = self.frame;
    frame.origin.x = lyLeft;
    self.frame = frame;
}

- (CGFloat)lyTop
{
    return self.frame.origin.y;
}

- (void)setLyTop:(CGFloat)lyTop
{
    CGRect frame = self.frame;
    frame.origin.y = lyTop;
    self.frame = frame;
}

- (CGFloat)lyRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLyRight:(CGFloat)lyRight
{
    CGRect frame = self.frame;
    frame.origin.x = lyRight - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lyBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLyBottom:(CGFloat)lyBottom
{
    CGRect frame = self.frame;
    frame.origin.y = lyBottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lyWidth
{
    return self.frame.size.width;
}

- (void)setLyWidth:(CGFloat)lyWidth
{
    CGRect frame = self.frame;
    frame.size.width = lyWidth;
    self.frame = frame;
}

- (CGFloat)lyHeight
{
    return self.frame.size.height;
}

- (void)setLyHeight:(CGFloat)lyHeight
{
    CGRect frame = self.frame;
    frame.size.height = lyHeight;
    self.frame = frame;
}

- (CGFloat)lyScreenX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.lyLeft;
    }
    return x;
}

- (CGFloat)lyScreenY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.lyTop;
    }
    return y;
}

- (CGPoint)lyOrigin
{
    return self.frame.origin;
}

- (void)setLyOrigin:(CGPoint)lyOrigin
{
    CGRect frame = self.frame;
    frame.origin = lyOrigin;
    self.frame = frame;
}

- (CGFloat)lyCenterX
{
    return self.center.x;
}

- (void)setLyCenterX:(CGFloat)lyCenterX
{
    self.center = CGPointMake(lyCenterX, self.center.y);
}

- (CGFloat)lyCenterY
{
    return self.center.y;
}

- (void)setLyCenterY:(CGFloat)lyCenterY
{
    self.center = CGPointMake(self.center.x, lyCenterY);
}

- (CGSize)lySize
{
    return self.frame.size;
}

- (void)setLySize:(CGSize)lySize
{
    CGRect frame = self.frame;
    frame.size = lySize;
    self.frame = frame;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(SKOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == SKOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == SKOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end
