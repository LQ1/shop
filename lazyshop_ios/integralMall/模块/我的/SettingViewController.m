//
//  SettingViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingViewController.h"

#import "SettingViewModel.h"

#import "SettingView.h"

#import "SetPasswordViewController.h"
#import "ModifyPasswordViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "LawProtocolViewController.h"

@interface SettingViewController ()

@property (nonatomic,strong)SettingViewModel *viewModel;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    self.viewModel = [SettingViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"设置";
    //主视图
    SettingView *mainView = [[SettingView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case SettingViewModel_Signal_Type_GotoModifyPassword:
            {
                // 跳转修改密码
                ModifyPasswordViewController *vc = [ModifyPasswordViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SettingViewModel_Signal_Type_GotoSetPassword:
            {
                // 跳转设置密码
                SetPasswordViewController *vc = [SetPasswordViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SettingViewModel_Signal_Type_GotoLaw:
            {
                // 跳转法律条款
                LawProtocolViewController *vc = [LawProtocolViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SettingViewModel_Signal_Type_GotoFeedBack:
            {
                // 跳转意见反馈
                FeedBackViewController *vc = [FeedBackViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case SettingViewModel_Signal_Type_GotoAboutUs:
            {
                // 跳转关于我们
                AboutUsViewController *vc = [AboutUsViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    // 观察登录状态
    [[[RACObserve([AccountService shareInstance], isLogin) takeUntil:self.rac_willDeallocSignal] distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if (![x boolValue]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
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
