//
//  RegisterViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RegisterViewController.h"

#import "LYMainColorButton.h"
#import "LoginPhoneAndVerifyCodeInputView.h"
#import "LoginProtocolView.h"
#import "RegisterRecommendView.h"

#import "RegisterViewModel.h"

#import "LawProtocolViewController.h"

@interface RegisterViewController ()

@property (nonatomic,strong)RegisterViewModel *viewModel;

@property (nonatomic,strong) LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView;
@property (nonatomic,strong) RegisterRecommendView *recommendView;
@property (nonatomic,strong) LYMainColorButton *registerButton;
@property (nonatomic,strong) LoginProtocolView *protocolView;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    self.viewModel = [RegisterViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航
    self.navigationBarView.titleLabel.text = @"注册";
    
    // 手机号+验证码输入框
    LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView = [[LoginPhoneAndVerifyCodeInputView alloc] initWithPhonePlaceHolder:@"请输入手机号" verifyCodePlaceHolder:@"请输入验证码"];
    self.phoneAndVerifyCodenputView = phoneAndVerifyCodenputView;
    [self.view addSubview:phoneAndVerifyCodenputView];
    [phoneAndVerifyCodenputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(LoginPhoneAndVerifyCodeHeight);
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(33);
    }];
    // 推荐人信息
    RegisterRecommendView *recommendView = [RegisterRecommendView new];
    self.recommendView = recommendView;
    [self.view addSubview:self.recommendView];
    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneAndVerifyCodenputView.bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo([recommendView fetchHeight]);
    }];
    // 注册
    self.registerButton = [[LYMainColorButton alloc] initWithTitle:@"注册"
                                                    buttonFontSize:MAX_LARGE_FONT_SIZE
                                                      cornerRadius:3];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendView.bottom).offset(25);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    // 服务条款
    LoginProtocolView *protocolView = [[LoginProtocolView alloc] initWithPrefixString:@"注册即表示您同意"];
    self.protocolView = protocolView;
    [self.view addSubview:protocolView];
    [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerButton.bottom).offset(25);
        make.height.mas_equalTo(LoginProtocolHeight);
        make.left.right.mas_equalTo(self.registerButton);
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
    
    // 推荐人信息
    RAC(self.viewModel,recommederType) = RACObserve(self.recommendView, recommederType);
    RAC(self.viewModel,recommenderPhone) = RACObserve(self.recommendView, recommenderPhone);

    // 点击 注册
    self.registerButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel registerButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.phoneAndVerifyCodenputView endEditting];
        [self.recommendView endEdit];
        [self.viewModel registerClick];
        return [RACSignal empty];
    }];
    
    // 注册+登录成功
    [self.viewModel.loginSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        // 登录成功
        [DLLoading DLToolTipInWindow:@"注册成功"];
        [[LoginCommonManager sharedInstance] popToFrontOfLoginViewControllerWithNavigationController:self.navigationController];
    }];
    
    // 点击 服务条款
    [self.protocolView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        LawProtocolViewController *vc = [LawProtocolViewController new];
        vc.viewModel = x;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
