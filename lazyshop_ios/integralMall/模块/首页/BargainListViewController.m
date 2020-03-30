//
//  BargainListViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BargainListViewController.h"

#import "BargainListViewModel.h"
#import "BargainListView.h"

#import "GoodsDetailViewController.h"

@interface BargainListViewController ()

@property (nonatomic,strong)BargainListViewModel *viewModel;
@property (nonatomic,strong)BargainListView *mainView;

@end

@implementation BargainListViewController

- (void)viewDidLoad
{
    self.viewModel = [BargainListViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindBaseSignal];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"懒店砍价";
    // 主视图
    self.mainView = [BargainListView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hasAppeard) {
        [self getData];
        self.hasAppeard = YES;
    }
}

// 获取数据
- (void)getData
{
    self.mainView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData:YES];
}

// 绑定基础信号
- (void)bindBaseSignal
{
    @weakify(self);
    [self.viewModel.tipLoadingSignal subscribeNext:^(id x) {
        [DLLoading DLToolTipInWindow:x];
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
    
    [self.viewModel.fetchListSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取成功
        self.mainView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        [self.mainView reloadDataWithViewModel:self.viewModel];
    }];
    
    [self.viewModel.fetchListFailedSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取数据失败
        NSError *error = x;
        NSString *title = AppErrorParsing(error);
        if (self.mainView.currentRefreshState == AT_NO_REFRESH_STATE) {
            [self.view DLLoadingCycleInSelf:^{
                @strongify(self);
                [self getData];
            } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
        }else{
            [self.mainView recoverShowState];
            [DLLoading DLToolTipInWindow:title];
        }
    }];
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case BargainListViewModel_Signal_Type_GotoGoodsDetail:
            {
                // 商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
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
