//
//  SecKillListViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListViewController.h"

#import "SecKillListViewModel.h"
#import "SecKillListView.h"

@interface SecKillListViewController ()

@end

@implementation SecKillListViewController

- (void)viewDidLoad {
    self.viewModel = [SecKillListViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"懒店秒杀";
    self.navigationBarView.navagationBarStyle = Left_button_Show;
    // 主界面
    self.mainView = [SecKillListView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    self.mainView.hidden = YES;
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case SecKillListViewModel_Signal_Type_AddToChildVC:
            {
                // addChildVC
                [self addChildViewController:x];
            }
                break;
            case SecKillListViewModel_Signal_Type_ReloadView:
            {
                // 刷新视图
                [(SecKillListView *)self.mainView reloadViews];
            }
                break;
                
            default:
                break;
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
