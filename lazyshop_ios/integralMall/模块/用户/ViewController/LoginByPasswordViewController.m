//
//  LoginViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginByPasswordViewController.h"

#import "LoginByPasswordViewModel.h"

#import "LoginTextButton.h"
#import "LoginPhoneInputView.h"
#import "LoginPasswordInputView.h"

#import "LoginByVerifyCodeViewController.h"
#import "FindPasswordViewController.h"

@interface LoginByPasswordViewController ()

@property (nonatomic,strong)LoginByPasswordViewModel *viewModel;

@property (nonatomic,strong)LoginPhoneInputView *phoneInputView;
@property (nonatomic,strong)LoginPasswordInputView *passWordInputView;

@end

@implementation LoginByPasswordViewController

- (void)viewDidLoad
{
    self.viewModel = [LoginByPasswordViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"密码登录";
    
    // 输入框
    self.passWordInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"请输入密码"
                                                                        tipTitle:@"密码"];
    [self.view addSubview:self.passWordInputView];
    [self.passWordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.loginButton.top).offset(-30);
        make.height.mas_equalTo(50);
    }];
    
    self.phoneInputView = [[LoginPhoneInputView alloc] initWithPlaceHolder:@"请输入手机号"
                                                                  tipTitle:@"手机号"];
    [self.view addSubview:self.phoneInputView];
    [self.phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.passWordInputView);
        make.bottom.mas_equalTo(self.passWordInputView.top);
    }];
    
    // 验证码登录
    LoginTextButton *loginByVerifyCodeBtn = [[LoginTextButton alloc] initWithTitle:@"验证码登录"];
    [self.view addSubview:loginByVerifyCodeBtn];
    [loginByVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LoginTextHeight);
        make.top.mas_equalTo(self.registerButton.bottom).offset(30);
        make.left.mas_equalTo(self.registerButton);
    }];
    @weakify(self);
    loginByVerifyCodeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        LoginByVerifyCodeViewController *vc = [LoginByVerifyCodeViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    }];
    // 找回密码
    LoginTextButton *findPasswordBtn = [[LoginTextButton alloc] initWithTitle:@"找回密码"];
    [self.view addSubview:findPasswordBtn];
    [findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(loginByVerifyCodeBtn);
        make.right.mas_equalTo(self.registerButton);
    }];
    findPasswordBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        FindPasswordViewController *vc = [FindPasswordViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    }];
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    // 弹框
    [self.viewModel.tipLoadingSignal subscribeNext:^(NSString *tip) {
        [DLLoading DLToolTipInWindow:tip];
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
    
    // 输入框和VM双向绑定
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,phoneNumber);
    RACChannelTerminal *fieldValue1Terminal = [self.phoneInputView.textField rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,password);
    RACChannelTerminal *fieldValue2Terminal = [self.passWordInputView.textField rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];
    
    // 手机号格式是否正确
    RAC(self.viewModel,isPhoneNumberTrue) = RACObserve(self.phoneInputView, isTrue);
    
    // 点击 登录
    self.loginButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel loginButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.phoneInputView.textField resignFirstResponder];
        [self.passWordInputView.textField resignFirstResponder];
        [self.viewModel login];
        return [RACSignal empty];
    }];
    
    // 登录成功
    [self.viewModel.loginSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        // 登录成功
        [DLLoading DLToolTipInWindow:@"登录成功"];
        [[LoginCommonManager sharedInstance] popToFrontOfLoginViewControllerWithNavigationController:self.navigationController];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
