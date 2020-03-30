//
//  LYBolderButton.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBolderButton.h"

@implementation LYBolderButton

- (instancetype)initWithBolderColorString:(NSString *)bolderColorString
                         titleColorString:(NSString *)titleColorString
                                    title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.layer.borderColor = [CommUtls colorWithHexString:bolderColorString].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        [self setTitleColor:[CommUtls colorWithHexString:titleColorString] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    }
    return self;
}

@end
