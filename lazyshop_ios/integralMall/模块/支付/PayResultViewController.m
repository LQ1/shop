//
//  PayResultViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PayResultViewController.h"

#import "PayResultView.h"
#import "PayResultViewModel.h"

#import "MJRefresh.h"

#import "GoodsDetailViewController.h"
#import "OrderDetailViewController.h"

@interface PayResultViewController ()

@property (nonatomic,strong)PayResultView *mainView;

@end

@implementation PayResultViewController

- (void)viewDidLoad
{
    self.closeInteractiveGesture = YES;
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hasAppeard) {
        [self.viewModel getData:YES];
        self.hasAppeard = YES;
    }
}

- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"支付结果";
    
    self.mainView = [PayResultView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView
                     isShowBottom:NO];
    [self.mainView reloadDataWithViewModel:self.viewModel];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case PayResultViewModel_SignalType_FetchGoodsSuccess:
            {
                // 获取为你推荐成功
                [self.mainView reloadDataWithViewModel:self.viewModel];
                NSArray *array = x;
                if (array.count % PageGetDataNumber || array.count == ((PayResultViewModel *)self.viewModel).oldDataCount) {
                    [self.mainView.mainTable.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mainView.mainTable.mj_footer endRefreshing];
                }
                ((PayResultViewModel *)self.viewModel).oldDataCount = array.count;
            }
                break;
            case PayResultViewModel_SignalType_FetchGoodsFailed:
            {
                // 获取为你推荐失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.mainView.mainTable.mj_header.state == MJRefreshStateRefreshing || self.mainView.mainTable.mj_footer.state == MJRefreshStateRefreshing) {
                    [self.mainView.mainTable.mj_header endRefreshing];
                    [self.mainView.mainTable.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }
            }
                break;
            case PayResultViewModel_SignalType_GotoGoodsDetail:
            {
                // 跳转商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case PayResultViewModel_SignalType_CheckOrder:
            {
                // 查看订单
                OrderDetailViewController *vc = [OrderDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case PayResultViewModel_SignalType_PayAgain:
            {
                // 重新支付
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)leftButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
