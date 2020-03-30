//
//  SecKillListPageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListPageViewController.h"

#import "SecKillListPageViewModel.h"
#import "SecKillListPageView.h"

#import "GoodsDetailViewController.h"

@interface SecKillListPageViewController ()

@property (nonatomic,strong)SecKillListPageView *mainView;

@end

@implementation SecKillListPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hasAppeard) {
        [self getData];
        self.hasAppeard = YES;
    }
}

- (void)getData
{
    self.mainView.hidden = YES;
    [self.viewModel getDataRefresh:YES];
    [self.view DLLoadingInSelf];
}

- (void)addViews
{
    self.mainView = [SecKillListPageView new];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case SecKillListPageViewModel_Signal_Type_FetchListSuccess:
            {
                // 获取数据成功
                self.mainView.viewModel = self.viewModel;
                self.mainView.autoDataArray = x;
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
            }
                break;
            case SecKillListPageViewModel_Signal_Type_FetchListFailed:
            {
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
            }
                break;
            case SecKillListPageViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case SecKillListPageViewModel_Signal_Type_GotoGoodsDetail:
            {
                // 进入商品详情
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
