//
//  LoginTextButton.m
//  NetSchool
//
//  Created by LY on 2017/4/10.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginTextButton.h"

@implementation LoginTextButton

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.titleLabel.font      = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
        [self setTitleColor:[CommUtls colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

@end
