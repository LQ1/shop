//
//  LoginPhoneInputView.m
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginPhoneInputView.h"

#import "CDELPhoneTextField.h"

@implementation LoginPhoneInputView

#pragma mark -添加输入框
- (void)initTextField
{
    // 手机号
    self.textField              = [CDELPhoneTextField new];
    self.textField.keyboardType = UIKeyboardTypePhonePad;
    self.textField.placeholder  = @"请输入手机号";
    
    RAC(self,isTrue)            = RACObserve(((CDELPhoneTextField *)self.textField), isTrue);
}

@end
