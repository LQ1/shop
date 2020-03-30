//
//  LoginPasswordInputView.m
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginPasswordInputView.h"

#import "CDELPassWordTextField.h"

@interface LoginPasswordInputView()

@property (nonatomic, strong) UIButton *visibleBtn;
@property (nonatomic, strong) UIButton *invisibleBtn;

@end

@implementation LoginPasswordInputView

#pragma mark -添加输入框
- (void)initTextField
{
    // 密码
    self.textField                 = [CDELPassWordTextField new];
    self.textField.placeholder     = @"请输入密码";
    self.textField.keyboardType    = UIKeyboardTypeASCIICapable;
    self.textField.secureTextEntry = YES;
    
    RAC(self,isTrue)               = RACObserve(((CDELPassWordTextField *)self.textField), isTrue);
}

#pragma mark -添加密码密文控制按钮
- (void)setUpCommonView
{
    [super setUpCommonView];
    // 密文明文切换
    _visibleBtn = [UIButton new];
    [_visibleBtn setImage:[UIImage imageNamed:@"visible_normal"] forState:UIControlStateNormal];
    [self addSubview:_visibleBtn];
    @weakify(self);
    [_visibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.right).offset(-10);
        make.centerY.equalTo(self.textField.centerY);
        make.height.equalTo(30);
        make.width.equalTo(30);
    }];
    _visibleBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.visibleBtn.hidden = YES;
        self.invisibleBtn.hidden = NO;
        self.textField.secureTextEntry = YES;
        return [RACSignal empty];
    }];
    _visibleBtn.hidden = YES;
    
    _invisibleBtn = [UIButton new];
    [_invisibleBtn setImage:[UIImage imageNamed:@"invisible_normal"] forState:UIControlStateNormal];
    [self addSubview:_invisibleBtn];
    [_invisibleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.mas_equalTo(self.visibleBtn);
    }];
    _invisibleBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.visibleBtn.hidden = NO;
        self.invisibleBtn.hidden = YES;
        self.textField.secureTextEntry = NO;
        return [RACSignal empty];
    }];
    _invisibleBtn.hidden = NO;
    
    // 修改密码输入框布局
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.tipLabel.right);
        make.right.mas_equalTo(self.visibleBtn.left).offset(-5);
    }];
}

@end
