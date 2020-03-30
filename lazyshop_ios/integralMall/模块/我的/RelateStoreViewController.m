//
//  RelateStoreViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RelateStoreViewController.h"

#import "ScanViewController.h"
#import "RelateStoreViewModel.h"
#import "RelateStoreView.h"

#import "StoreDetailViewController.h"

@interface RelateStoreViewController ()

@end

@implementation RelateStoreViewController

- (void)viewDidLoad
{
    self.viewModel = [RelateStoreViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"关联店铺";
    self.loadingFailedImageName = @"没有关联店铺";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    [self.navigationBarView.rightButton setImage:[UIImage imageNamed:@"导航栏扫一扫图标"] forState:UIControlStateNormal];
    // 主视图
    self.mainView = [RelateStoreView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case RelateStoreViewModel_Signal_Type_GotoStoreDetail:
            {
                // 跳转店铺详情
                StoreDetailViewController *vc = [StoreDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case RelateStoreViewModel_Signal_Type_GotoScan:
            {
                // 跳转扫一扫
                [self gotoScanViewController];
            }
                break;
                
            default:
                break;
        }
    }];
    
    [((RelateStoreViewModel *)self.viewModel).showToScanSignal subscribeNext:^(id x) {
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
}

- (void)rightButtonClick
{
    [self gotoScanViewController];
}

- (void)gotoScanViewController
{
    ScanViewController *vc = [ScanViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hasAppeard = NO;
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
