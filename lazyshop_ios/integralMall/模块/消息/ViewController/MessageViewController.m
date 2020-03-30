//
//  MessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageViewController.h"

#import "MessageView.h"
#import "MessageViewModel.h"

#import "MessageSettingViewController.h"

#import "SystemMessageViewController.h"
#import "CouponMessageViewController.h"
#import "ScoreMessageViewController.h"
#import "OrderMessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad
{
    self.viewModel = [MessageViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"消息中心";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    [self.navigationBarView.rightButton setImage:[UIImage imageNamed:@"导航栏设置图标"] forState:UIControlStateNormal];
    // mainview
    self.mainView = [MessageView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MineViewModel_Signal_Type_GotoSystemMsg:
            {
                // 平台消息
                SystemMessageViewController *vc = [SystemMessageViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                self.hasAppeard = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case MineViewModel_Signal_Type_GotoCouponMsg:
            {
                // 优惠券消息
                CouponMessageViewController *vc = [CouponMessageViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                self.hasAppeard = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case MineViewModel_Signal_Type_GotoScoreMsg:
            {
                // 积分消息
                ScoreMessageViewController *vc = [ScoreMessageViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                self.hasAppeard = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case MineViewModel_Signal_Type_GotoOrderMsg:
            {
                // 订单消息
                OrderMessageViewController *vc = [OrderMessageViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                self.hasAppeard = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)rightButtonClick
{
    MessageSettingViewController *vc = [MessageSettingViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    self.hasAppeard = NO;
    [self.navigationController pushViewController:vc animated:YES];
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
