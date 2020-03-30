//
//  UIView+AddSub.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddSub)

/*
 *  添加imageView
 */
- (UIImageView *)addImageViewWithImageName:(NSString *)imageName
                              cornerRadius:(CGFloat)cornerRadius;

/*
 *  添加label
 */
- (UILabel *)addLabelWithFontSize:(CGFloat)fontSize
                    textAlignment:(NSTextAlignment)textAlignment
                        textColor:(NSString *)textColor
                     adjustsWidth:(BOOL)adjustsWidth
                     cornerRadius:(CGFloat)cornerRadius
                             text:(NSString *)text;

@end
