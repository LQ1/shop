//
//  MyOrdersViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersViewController.h"

#import "MyOrdersViewModel.h"
#import "MyOrdersView.h"

#import "OrderDetailViewController.h"
#import "PaymentViewController.h"

@interface MyOrdersViewController ()

@property (nonatomic,strong)MyOrdersView *mainView;

@end

@implementation MyOrdersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"我的订单";
    UIButton *cartBtn = [[PublicEventManager shareInstance] fetchShoppingCartButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:cartBtn];
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.navigationBarView.titleLabel);
    }];
    // 主视图
    self.mainView = [[MyOrdersView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyOrdersViewModel_Signal_Type_GotoOrderDetail:
            {
                // 跳转订单详情
                OrderDetailViewController *detailVC = [OrderDetailViewController new];
                detailVC.viewModel = x;
                detailVC.hidesBottomBarWhenPushed = YES;
                detailVC.reloadOrderListBlock = ^{
                    @strongify(self);
                    [self.mainView getData];
                };
                [self.navigationController pushViewController:detailVC animated:YES];
            }
                break;
            case MyOrdersViewModel_Signal_Type_GotoPayment:
            {
                // 跳转支付
                PaymentViewController *paymentVC = [PaymentViewController new];
                paymentVC.viewModel = x;
                paymentVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:paymentVC animated:YES];
            }
                break;
                
            default:
                break;
        }
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
