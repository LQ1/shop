//
//  OrderMessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderMessageViewController.h"

#import "OrderMessageViewModel.h"
#import "OrderMessageView.h"

#import "OrderDetailViewController.h"

@interface OrderMessageViewController ()

@end

@implementation OrderMessageViewController

- (void)viewDidLoad
{
    self.viewModel = [OrderMessageViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"订单消息";
    self.loadingFailedImageName = @"没有此类消息";
    self.mainView = [OrderMessageView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [((OrderMessageViewModel *)self.viewModel).gotoOrderDetailSignal subscribeNext:^(id x) {
        @strongify(self);
        OrderDetailViewController *vc = [OrderDetailViewController new];
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
