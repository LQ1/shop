//
//  OrderDetailViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailViewController.h"

#import "OrderDetailView.h"
#import "OrderDetailViewModel.h"
#import "MJRefresh.h"

#import "GoodsDetailViewController.h"
#import "DeliveryViewController.h"
#import "PaymentViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = ((OrderDetailViewModel *)self.viewModel).orderTitle;
    UIButton *cartBtn = [[PublicEventManager shareInstance] fetchShoppingCartButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:cartBtn];
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.navigationBarView.titleLabel);
    }];
    // 主视图
    self.mainView = [OrderDetailView new];
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
            case OrderDetailViewModel_Signal_Type_GetRecommentSuccess:
            {
                // 获取为你推荐成功
                [self.mainView reloadDataWithViewModel:self.viewModel];
                NSArray *array = x;
                if (array.count % PageGetDataNumber || array.count == ((OrderDetailViewModel *)self.viewModel).oldDataCount) {
                    [((OrderDetailView *)self.mainView).mainTable.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [((OrderDetailView *)self.mainView).mainTable.mj_footer endRefreshing];
                }
                ((OrderDetailViewModel *)self.viewModel).oldDataCount = array.count;
            }
                break;
            case OrderDetailViewModel_Signal_Type_GetRecommentFailed:
            {
                // 获取为你推荐失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (((OrderDetailView *)self.mainView).mainTable.mj_footer.state == MJRefreshStateRefreshing) {
                    [((OrderDetailView *)self.mainView).mainTable.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }
            }
                break;
            case OrderDetailViewModel_Signal_Type_GotoGoodsDetail:
            {
                // 跳转商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case OrderDetailViewModel_Signal_Type_GotoDeliveryTrack:
            {
                // 跳转快递追踪
                DeliveryViewController *vc = [DeliveryViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case OrderDetailViewModel_Signal_Type_GotoPop:
            {
                // 推出
                if (self.reloadOrderListBlock) {
                    self.reloadOrderListBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case OrderDetailViewModel_Signal_Type_GotoPayment:
            {
                // 付款
                PaymentViewController *vc = [PaymentViewController new];
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

- (void)leftButtonClick
{
    if (((OrderDetailViewModel *)self.viewModel).rootPop) {
        [self.navigationController popToRootViewControllerAnimated:YES];
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
