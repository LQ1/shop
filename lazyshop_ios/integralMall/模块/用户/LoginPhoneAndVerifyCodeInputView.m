//
//  LoginPhoneAndVerifyCodeInputView.m
//  NetSchool
//
//  Created by LY on 2017/4/11.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginPhoneAndVerifyCodeInputView.h"

#import "LoginPhoneAndVerifyCodeInputViewModel.h"

#import "LoginPhoneInputView.h"
#import "LoginVerifyCodeInputView.h"

@interface LoginPhoneAndVerifyCodeInputView ()

@property (nonatomic,strong) LoginPhoneAndVerifyCodeInputViewModel *viewModel;

@property (nonatomic,copy  ) NSString                              *phonePlaceHolder;
@property (nonatomic,copy  ) NSString                              *verifyCodePlaceHolder;

@property (nonatomic,strong) LoginPhoneInputView                   *phoneInputView;
@property (nonatomic,strong) LoginVerifyCodeInputView              *verifyInputView;

@end

@implementation LoginPhoneAndVerifyCodeInputView

#pragma mark -初始化
- (instancetype)initWithPhonePlaceHolder:(NSString *)phonePlaceHolder
                   verifyCodePlaceHolder:(NSString *)verifyCodePlaceHolder
{
    if (self = [super init]) {
        self.phonePlaceHolder      = phonePlaceHolder;
        self.verifyCodePlaceHolder = verifyCodePlaceHolder;
        [self addViews];
    }
    return self;
}

#pragma mark -添加界面
- (void)addViews
{
    // 手机号
    LoginPhoneInputView *phoneInputView       = [[LoginPhoneInputView alloc] initWithPlaceHolder:self.phonePlaceHolder tipTitle:@"手机号"];
    self.phoneInputView                       = phoneInputView;
    [self addSubview:phoneInputView];
    @weakify(self);
    [phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(LoginInputHeight);
    }];
    // 验证码
    LoginVerifyCodeInputView *verifyInputView = [[LoginVerifyCodeInputView alloc] initWithPlaceHolder:self.verifyCodePlaceHolder tipTitle:@"验证码"];
    self.verifyInputView                      = verifyInputView;
    [self addSubview:verifyInputView];
    [verifyInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.height.mas_equalTo(self.phoneInputView);
        make.top.mas_equalTo(self.phoneInputView.bottom);
    }];
}

#pragma mark -绑定ViewModel
- (void)bindViewModel:(LoginPhoneAndVerifyCodeInputViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 输入框和VM双向绑定
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,phoneNumber);
    RACChannelTerminal *fieldValue1Terminal = [self.phoneInputView.textField rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,verifyCode);
    RACChannelTerminal *fieldValue2Terminal = [self.verifyInputView.textField rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];
    
    // 手机号格式是否正确
    RAC(self.viewModel,isPhoneNumberTrue) = RACObserve(self.phoneInputView, isTrue);
    
    // 点击 获取验证码
    @weakify(self);
    self.verifyInputView.sendVerifyCodeBtn.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel codeValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!self.phoneInputView.isTrue) {
            [DLLoading DLToolTipInWindow:@"请输入正确的手机号"];
        }else{
            [self.viewModel fetchVerifyCode];
        }
        return [RACSignal empty];
    }];
    // 验证码倒计时
    [[RACObserve(self.viewModel,remainingSec) filter:^BOOL (id value) {
        return [value integerValue] > 0;
    }] subscribeNext:^(id x) {
        @strongify(self);
        [self.verifyInputView.sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ds", (int)[x integerValue]] forState:UIControlStateDisabled];
    }];
    
    // 验证码发送成功
    [self.viewModel.fetchVerifyCodeSuccessSignal subscribeNext:^(id x) {
        [DLLoading DLToolTipInWindow:@"验证码已发送至您的手机"];
    }];

    // 验证码发送失败
    [self.viewModel.fetchVerifyCodeErrorSignal subscribeNext:^(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
    }];
    
    // 监测loading状态
    [RACObserve(self.viewModel, loading) subscribeNext:^(id x) {
        if ([x boolValue]) {
            [DLLoading DLLoadingInWindow:nil close:^{
                @strongify(self);
                [self.viewModel dispose];
            }];
        }else{
            [DLLoading DLHideInWindow];
        }
    }];
}

#pragma mark -结束编辑
- (void)endEditting
{
    [self.phoneInputView.textField resignFirstResponder];
    [self.verifyInputView.textField resignFirstResponder];
}

@end
