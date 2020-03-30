//
//  SetPasswordViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SetPasswordViewController.h"

#import "SetPasswordViewModel.h"

#import "LoginPhoneInputView.h"
#import "LoginPasswordInputView.h"
#import "LYMainColorButton.h"

@interface SetPasswordViewController ()

@property (nonatomic,strong)LoginPhoneInputView *phoneInputView;
@property (nonatomic,strong)LoginPasswordInputView *passwordInputView;
@property (nonatomic,strong)LoginPasswordInputView *confirmPasswordInputView;
@property (nonatomic,strong)LYMainColorButton *submitButton;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"设置新密码";
    
    // 输入框
    self.phoneInputView = [[LoginPhoneInputView alloc] initWithPlaceHolder:nil
                                                                  tipTitle:@"手机号"];
    self.phoneInputView.textField.textColor = [CommUtls colorWithHexString:@"#666666"];
    self.phoneInputView.textField.text = self.viewModel.phoneNumber;
    self.phoneInputView.textField.enabled = NO;
    [self.view addSubview:self.phoneInputView];
    [self.phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(55);
    }];
    
    self.passwordInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"6-16位数字与字母"
                                                                        tipTitle:@"新密码"];
    [self.view addSubview:self.passwordInputView];
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.phoneInputView);
        make.top.mas_equalTo(self.phoneInputView.bottom);
    }];
    
    self.confirmPasswordInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"请再次输入新密码"
                                                                               tipTitle:@"确认密码"];
    [self.view addSubview:self.confirmPasswordInputView];
    [self.confirmPasswordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.passwordInputView);
        make.top.mas_equalTo(self.passwordInputView.bottom);
    }];
    
    // 确定按钮
    self.submitButton = [[LYMainColorButton alloc] initWithTitle:@"确定"
                                                  buttonFontSize:MAX_LARGE_FONT_SIZE
                                                    cornerRadius:3];
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmPasswordInputView.bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
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
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,password);
    RACChannelTerminal *fieldValue1Terminal = [self.passwordInputView.textField rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,confirmPassword);
    RACChannelTerminal *fieldValue2Terminal = [self.confirmPasswordInputView.textField rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];
    
    // 手机号格式是否正确
    RAC(self.viewModel,isPasswordTrue) = RACObserve(self.passwordInputView, isTrue);
    
    // 点击 确定
    self.submitButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel submitButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.passwordInputView.textField resignFirstResponder];
        [self.confirmPasswordInputView.textField resignFirstResponder];
        [self.viewModel submit];
        return [RACSignal empty];
    }];
    
    // 密码设置成功
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [DLLoading DLToolTipInWindow:@"密码设置成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
