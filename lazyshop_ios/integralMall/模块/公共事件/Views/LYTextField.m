//
//  LYTextField.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYTextField.h"

@interface LYTextField()

@property (nonatomic,assign)LYTextFieldStyle style;

@end

@implementation LYTextField

#pragma mark -初始化
- (instancetype)initWithStyle:(LYTextFieldStyle)style
                  placeHolder:(NSString *)placeHolder
{
    self = [super init];
    if (self) {
        // 共有属性
        self.clearButtonMode          = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.font                     = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
        self.placeholder  = placeHolder;
        // 个性化
        self.style = style;
        switch (style) {
            case LYTextFieldStyle_Name:
            {
                self.keyboardType = UIKeyboardTypeDefault;
            }
                break;
            case LYTextFieldStyle_Phone:
            {
                self.keyboardType = UIKeyboardTypePhonePad;
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

#pragma mark -格式校验
// 是否手机号
- (BOOL)isPhoneNumberTrue
{
    NSString *regex = @"^((13[0-9])|(17[0,0-9])|(147)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}

@end
