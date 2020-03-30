//
//  LYTextColorButton.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYTextColorButton.h"

@implementation LYTextColorButton

- (instancetype)initWithTitle:(NSString *)buttonTitle
               buttonFontSize:(NSInteger)buttonFontSize
                 cornerRadius:(NSInteger)cornerRadius
{
    self = [super init];
    if (self) {
        self.layer.borderWidth = 1./[UIScreen mainScreen].scale;
        self.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
        // 字号
        self.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
        [self setTitle:buttonTitle forState:UIControlStateNormal];
        [self setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
        // 圆角
        if (cornerRadius>0) {
            self.layer.cornerRadius = cornerRadius;
            self.layer.masksToBounds = YES;
        }
    }
    return self;
}

@end
