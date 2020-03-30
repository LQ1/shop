//
//  MyGroupBuyViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyGroupBuyViewController.h"

#import "MyGroupBuyView.h"
#import "MyGroupBuyViewModel.h"

#import "GroupBuyProgressViewController.h"

@interface MyGroupBuyViewController ()

@property (nonatomic,strong)MyGroupBuyViewModel *viewModel;
@property (nonatomic,strong)MyGroupBuyView *mainView;

@end

@implementation MyGroupBuyViewController

- (void)viewDidLoad
{
    self.viewModel = [MyGroupBuyViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
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

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"我的拼团";
    UIButton *cartBtn = [[PublicEventManager shareInstance] fetchShoppingCartButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:cartBtn];
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.navigationBarView.titleLabel);
    }];
    // 主视图
    self.mainView = [MyGroupBuyView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

// 绑定基础信号
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        switch (self.viewModel.currentSignalType) {
            case MyGroupBuyViewModel_Signal_Type_GotoGroupDetail:
            {
                // 拼团详情
                NSArray *params = x;
                GroupBuyProgressViewController *vc = [GroupBuyProgressViewController new];
                vc.urlString = [params firstObject];
                vc.inviteFriendsBlock = [params lastObject];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    
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
    
    [self.viewModel.reloadViewSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取成功
        [self.mainView reloadDataWithViewModel:self.viewModel];
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
