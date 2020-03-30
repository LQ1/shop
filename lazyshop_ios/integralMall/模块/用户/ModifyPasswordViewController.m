//
//  ModifyPasswordViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ModifyPasswordViewController.h"

#import "ModifyPasswordViewModel.h"

#import "LoginPasswordInputView.h"
#import "LYMainColorButton.h"

@interface ModifyPasswordViewController ()

@property (nonatomic,strong)ModifyPasswordViewModel *viewModel;

@property (nonatomic,strong)LoginPasswordInputView *oldPasswordInputView;
@property (nonatomic,strong)LoginPasswordInputView *nPasswordInputView;
@property (nonatomic,strong)LoginPasswordInputView *nPasswordComfirmInputView;
@property (nonatomic,strong)LYMainColorButton *submitButton;

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad
{
    self.viewModel  = [ModifyPasswordViewModel new];
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
    self.oldPasswordInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"6-16位数字与字母"
                                                                           tipTitle:@"旧密码"];
    [self.view addSubview:self.oldPasswordInputView];
    [self.oldPasswordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(55);
    }];
    
    self.nPasswordInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"6-16位数字与字母"
                                                                         tipTitle:@"新密码"];
    [self.view addSubview:self.nPasswordInputView];
    [self.nPasswordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.oldPasswordInputView);
        make.top.mas_equalTo(self.oldPasswordInputView.bottom);
    }];
    
    self.nPasswordComfirmInputView = [[LoginPasswordInputView alloc] initWithPlaceHolder:@"请再次输入新密码"
                                                                                tipTitle:@"确认密码"];
    [self.view addSubview:self.nPasswordComfirmInputView];
    [self.nPasswordComfirmInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.nPasswordInputView);
        make.top.mas_equalTo(self.nPasswordInputView.bottom);
    }];
    
    // 确定按钮
    self.submitButton = [[LYMainColorButton alloc] initWithTitle:@"确定"
                                                  buttonFontSize:MAX_LARGE_FONT_SIZE
                                                    cornerRadius:3];
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nPasswordComfirmInputView.bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    // 设置密码成功
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [DLLoading DLToolTipInWindow:@"密码修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
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
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,oldPassword);
    RACChannelTerminal *fieldValue1Terminal = [self.oldPasswordInputView.textField rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,nPassword);
    RACChannelTerminal *fieldValue2Terminal = [self.nPasswordInputView.textField rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];
    
    RACChannelTerminal *modelValue3Terminal = RACChannelTo(self.viewModel,nConfirmPassword);
    RACChannelTerminal *fieldValue3Terminal = [self.nPasswordComfirmInputView.textField rac_newTextChannel];
    [modelValue3Terminal subscribe:fieldValue3Terminal];
    [fieldValue3Terminal subscribe:modelValue3Terminal];
    
    // 手机号格式是否正确
    RAC(self.viewModel,isNewPasswordTrue) = RACObserve(self.nPasswordInputView, isTrue);
    
    // 点击 确定
    self.submitButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel submitButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.oldPasswordInputView.textField resignFirstResponder];
        [self.nPasswordInputView.textField resignFirstResponder];
        [self.nPasswordComfirmInputView.textField resignFirstResponder];
        [self.viewModel submit];
        return [RACSignal empty];
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
