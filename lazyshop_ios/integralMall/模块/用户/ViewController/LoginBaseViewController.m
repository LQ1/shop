//
//  LoginBaseViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewController.h"

#import "RegisterViewController.h"

@interface LoginBaseViewController ()

@end

@implementation LoginBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // addViews
    self.view.backgroundColor = [UIColor whiteColor];
    // 登录
    self.loginButton = [[LYMainColorButton alloc] initWithTitle:@"登录"
                                                 buttonFontSize:MAX_LARGE_FONT_SIZE
                                                   cornerRadius:3];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(163);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    // 注册
    self.registerButton = [[LYTextColorButton alloc] initWithTitle:@"注册"
                                                    buttonFontSize:MAX_LARGE_FONT_SIZE
                                                      cornerRadius:3];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.bottom).offset(27.5);
        make.left.right.height.mas_equalTo(self.loginButton);
    }];
    @weakify(self);
    self.registerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        RegisterViewController *vc = [RegisterViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
