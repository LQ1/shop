//
//  LYMainColorButton.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYMainColorButton.h"

@implementation LYMainColorButton

- (instancetype)initWithTitle:(NSString *)buttonTitle
               buttonFontSize:(NSInteger)buttonFontSize
                 cornerRadius:(NSInteger)cornerRadius
{
    self = [super init];
    if (self) {
        // 背景
        [self setBackgroundImage:[self createImageWithColor:[CommUtls colorWithHexString:APP_MainColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[self createImageWithColor:[CommUtls colorWithHexString:@"#eeeeee"]] forState:UIControlStateDisabled];
        // 字体
        [self setTitleColor:[CommUtls colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self setTitleColor:[CommUtls colorWithHexString:@"#cecece"] forState:UIControlStateDisabled];
        // 字号
        self.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
        [self setTitle:buttonTitle forState:UIControlStateNormal];
        // 圆角
        if (cornerRadius>0) {
            self.layer.cornerRadius = cornerRadius;
            self.layer.masksToBounds = YES;
        }
    }
    return self;
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
