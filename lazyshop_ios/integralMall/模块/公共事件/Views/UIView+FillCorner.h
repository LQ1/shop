//
//  UIView+FillCorner.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FillCorner)

- (void)lyFillTopCornerWithWidth:(CGFloat)width
                     colorString:(NSString *)color;

- (void)lyFillBottomCornerWithWidth:(CGFloat)width
                        colorString:(NSString *)color;

@end
