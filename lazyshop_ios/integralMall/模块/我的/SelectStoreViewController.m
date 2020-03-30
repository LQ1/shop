//
//  SelectStoreViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SelectStoreViewController.h"

#import "SelectStoreViewModel.h"
#import "SelectStoreView.h"

#import "ScanViewController.h"

@interface SelectStoreViewController ()

@end

@implementation SelectStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"选择关联店铺";
    self.loadingFailedImageName = @"没有关联店铺";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"确定";
    // 主视图
    self.mainView = [SelectStoreView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    self.mainView.hidden = YES;
}

- (void)bindSignal
{
    @weakify(self);
    [((SelectStoreViewModel *)self.viewModel).showToScanSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.view DLLoadingCustomInSelf:self.loadingFailedImageName
                                    code:DLDataFailed
                                   title:x
                                   cycle:^{
                                       @strongify(self);
                                       [self gotoScanViewController];
                                   }
                             buttonTitle:@"扫一扫"];
    }];
    
    [((SelectStoreViewModel *)self.viewModel).bindShopSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        [DLLoading DLToolTipInWindow:@"绑定店铺成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)gotoScanViewController
{
    ScanViewController *vc = [ScanViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hasAppeard = NO;
}

- (void)rightButtonClick
{
    [((SelectStoreViewModel *)self.viewModel) bindSelectShop];
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
