//
//  LoginByVerifyCodeViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginByVerifyCodeViewController.h"

#import "LoginByVerifyCodeViewModel.h"

#import "LoginPhoneAndVerifyCodeInputView.h"
#import "LoginTextButton.h"

@interface LoginByVerifyCodeViewController ()

@property (nonatomic,strong)LoginByVerifyCodeViewModel *viewModel;

@property (nonatomic,strong)LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView;

@end

@implementation LoginByVerifyCodeViewController

- (void)viewDidLoad
{
    self.viewModel = [LoginByVerifyCodeViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"验证码登录";
    
    // 输入框
    LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView = [[LoginPhoneAndVerifyCodeInputView alloc] initWithPhonePlaceHolder:@"请输入手机号" verifyCodePlaceHolder:@"请输入验证码"];
    self.phoneAndVerifyCodenputView = phoneAndVerifyCodenputView;
    [self.view addSubview:phoneAndVerifyCodenputView];
    [phoneAndVerifyCodenputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(LoginPhoneAndVerifyCodeHeight);
        make.bottom.mas_equalTo(self.loginButton.top).offset(-30);
    }];
    
    // 手机号登录
    LoginTextButton *loginByPasswordBtn = [[LoginTextButton alloc] initWithTitle:@"手机号登录"];
    [self.view addSubview:loginByPasswordBtn];
    [loginByPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LoginTextHeight);
        make.top.mas_equalTo(self.registerButton.bottom).offset(30);
        make.left.mas_equalTo(self.registerButton);
    }];
    @weakify(self);
    loginByPasswordBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
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
    [self.phoneAndVerifyCodenputView bindViewModel:[self.viewModel fetchPhoneAndVerifyCodeInputViewModel]];
    
    // 点击 登录
    self.loginButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel loginButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.phoneAndVerifyCodenputView endEditting];
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
