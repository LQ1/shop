//
//  CashBackViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackViewController.h"

#import "CashBackView.h"
#import "CashBackViewModel.h"
#import "CashBackHistoryViewController.h"

#import "OrderDetailViewController.h"
#import "SelectStoreViewController.h"

@interface CashBackViewController ()

@end

@implementation CashBackViewController

- (void)viewDidLoad
{
    self.viewModel = [CashBackViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"返利列表";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"返利历史";
    // 主界面
    self.mainView = [CashBackView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case CashBackViewModel_Signal_Type_GotoOrderDetail:
            {
                // 订单详情
                OrderDetailViewController *vc = [OrderDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case CashBackViewModel_Signal_Type_GotoBindShop:
            {
                // 选择关联店铺
                self.hasAppeard = NO;
                SelectStoreViewController *vc = [SelectStoreViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
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
    CashBackHistoryViewController *vc = [CashBackHistoryViewController new];
    vc.hidesBottomBarWhenPushed = YES;
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
