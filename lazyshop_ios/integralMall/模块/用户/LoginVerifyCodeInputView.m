//
//  LoginVerifyCodeInputView.m
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginVerifyCodeInputView.h"

@implementation LoginVerifyCodeInputView

- (void)initTextField
{
    // 短信验证码
    self.textField              = [UITextField new];
    self.textField.placeholder  = @"短信验证码";
    self.textField.keyboardType = UIKeyboardTypeASCIICapable;
}

- (void)setUpCommonView
{
    [super setUpCommonView];
    // 获取验证码按钮
    _sendVerifyCodeBtn = [[LYMainColorButton alloc] initWithTitle:@"发送验证码"
                                                   buttonFontSize:MIDDLE_FONT_SIZE
                                                     cornerRadius:2];
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(90.0f);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(8);
    }];
    
    // 修改输入框布局
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.tipLabel.right);
        make.right.mas_equalTo(_sendVerifyCodeBtn.left);
    }];
    
}

@end
