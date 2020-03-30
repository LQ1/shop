//
//  UIView+AddSub.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "UIView+AddSub.h"

@implementation UIView (AddSub)

#pragma mark -添加imageView
- (UIImageView *)addImageViewWithImageName:(NSString *)imageName
                              cornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (cornerRadius>0) {
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = cornerRadius;
    }
    if (imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    [self addSubview:imageView];
    return imageView;
}

#pragma mark -添加label
- (UILabel *)addLabelWithFontSize:(CGFloat)fontSize
                    textAlignment:(NSTextAlignment)textAlignment
                        textColor:(NSString *)textColor
                     adjustsWidth:(BOOL)adjustsWidth
                     cornerRadius:(CGFloat)cornerRadius
                             text:(NSString *)text
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    label.textColor = [CommUtls colorWithHexString:textColor];
    label.adjustsFontSizeToFitWidth = adjustsWidth;
    if (cornerRadius>0) {
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = cornerRadius;
    }
    if (text.length) {
        label.text = text;
    }
    [self addSubview:label];
    return label;
}

@end
