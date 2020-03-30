//
//  ShippingAddressEidtViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressEidtViewController.h"

#import "ShippingAddressEidtView.h"
#import "ShippingAddressEidtViewModel.h"

@interface ShippingAddressEidtViewController ()

@end

@implementation ShippingAddressEidtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 导航
    self.navigationBarView.titleLabel.text = [(ShippingAddressEidtViewModel *)self.viewModel fetchNavTitle];
    self.navigationBarView.navagationBarStyle = Left_button_Show;
    // 主视图
    ShippingAddressEidtView *mainView = [ShippingAddressEidtView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark -返回
- (void)leftButtonClick
{
    [(ShippingAddressEidtView *)self.mainView endEditting];
    if ([(ShippingAddressEidtViewModel *)self.viewModel needWarningToSave]) {
        LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                        message:@"修改的信息还未保存\n确认现在返回吗"
                                                         titles:@[@"取消",@"确定"]
                                                          click:^(NSInteger index) {
                                                              if (index == 1) {
                                                                  [super leftButtonClick];
                                                              }
                                                          }];
        [alert show];
    }else{
        [super leftButtonClick];
    }
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
