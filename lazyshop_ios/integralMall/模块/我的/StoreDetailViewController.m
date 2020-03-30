//
//  StoreDetailViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreDetailViewController.h"

#import "StoreDetailViewModel.h"
#import "StoreDetailView.h"

@interface StoreDetailViewController ()

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"店铺详情";
    self.loadingFailedImageName = @"没有关联店铺";
    // 主视图
    self.mainView = [StoreDetailView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
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
