//
//  MyCouponsViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyCouponsViewController.h"

#import "MyCouponsViewModel.h"
#import "MyCouponsView.h"

#import "ProductListViewController.h"

@interface MyCouponsViewController ()

@property (nonatomic,strong)MyCouponsView *mainView;

@end

@implementation MyCouponsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 绑定vm
    [self.mainView bindViewModel:self.viewModel];
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"优惠券";
    // 主界面
    self.mainView = [MyCouponsView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyCouponsViewModel_Signal_Type_GotoProductList:
            {
                // 商品列表
                ProductListViewController *vc = [ProductListViewController new];
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
