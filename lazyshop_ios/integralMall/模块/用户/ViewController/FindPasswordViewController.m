//
//  FindPasswordViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FindPasswordViewController.h"

#import "LYMainColorButton.h"
#import "LoginPhoneAndVerifyCodeInputView.h"

#import "FindPasswordViewModel.h"

#import "SetPasswordViewController.h"

@interface FindPasswordViewController ()

@property (nonatomic,strong)FindPasswordViewModel *viewModel;

@property (nonatomic,strong) LYMainColorButton *nextButton;
@property (nonatomic,strong) LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView;

@end

@implementation FindPasswordViewController

- (void)viewDidLoad
{
    self.viewModel = [FindPasswordViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"找回密码";
    // 下一步
    self.nextButton = [[LYMainColorButton alloc] initWithTitle:@"下一步"
                                                buttonFontSize:MAX_LARGE_FONT_SIZE
                                                  cornerRadius:3];
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(163);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    // 输入框
    LoginPhoneAndVerifyCodeInputView *phoneAndVerifyCodenputView = [[LoginPhoneAndVerifyCodeInputView alloc] initWithPhonePlaceHolder:@"请输入手机号" verifyCodePlaceHolder:@"请输入验证码"];
    self.phoneAndVerifyCodenputView = phoneAndVerifyCodenputView;
    [self.view addSubview:phoneAndVerifyCodenputView];
    [phoneAndVerifyCodenputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(LoginPhoneAndVerifyCodeHeight);
        make.bottom.mas_equalTo(self.nextButton.top).offset(-30);
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
    
    // 点击 注册
    self.nextButton.rac_command = [[RACCommand alloc] initWithEnabled:[self.viewModel nextButtonValidSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.phoneAndVerifyCodenputView endEditting];
        [self.viewModel nextClick];
        return [RACSignal empty];
    }];
    
    // 跳转设置密码
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        SetPasswordViewController *vc = [SetPasswordViewController new];
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
