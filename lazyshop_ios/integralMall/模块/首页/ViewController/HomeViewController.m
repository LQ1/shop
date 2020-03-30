//
//  HomeViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeViewController.h"

#import "MJRefresh.h"

#import "HomeNavgationBarView.h"
#import "HomeView.h"
#import "HomeViewModel.h"

#import "SecKillListViewController.h"
#import "GroupBuyListViewController.h"
#import "BargainListViewController.h"
#import "GoodsDetailViewController.h"
#import "ProductListViewController.h"
#import "RegPartnerViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong)HomeNavgationBarView *homeNavView;
@property (nonatomic,strong)HomeView *mainView;
@property (nonatomic,strong)HomeViewModel *viewModel;
@property (nonatomic,strong)UIButton *backToTopButton;
@property (nonatomic,strong)UIButton *costomerButton;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel  = [HomeViewModel new];
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

// 获取数据
- (void)getData
{
    self.mainView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

#pragma mark -主界面
- (void)addViews
{
    // 导航
    self.navigationBarView.navagationBarStyle = None_button_show;
    HomeNavgationBarView *homeNavView = [HomeNavgationBarView new];
    self.homeNavView = homeNavView;
    [self.navigationBarView addSubview:homeNavView];
    [homeNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.right.bottom.mas_equalTo(0);
    }];
    // 背景
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#EAEAEA"];
    // 主视图
    HomeView *mainView = [[HomeView alloc] initWithViewModel:self.viewModel];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:YES];
    // 返回顶部按钮
    self.backToTopButton = [UIButton new];
    [self.backToTopButton setImage:[UIImage imageNamed:@"返回顶部"] forState:UIControlStateNormal];
    [self.view addSubview:self.backToTopButton];
    [self.backToTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(55);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-15-TABLE_BAR_HEIGHT);
    }];
    @weakify(self);
    self.backToTopButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.mainView.mainTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        return [RACSignal empty];
    }];
    self.backToTopButton.hidden = YES;
    // 联系客服按钮
    self.costomerButton = [UIButton new];
    [self.costomerButton setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
    [self.view addSubview:self.costomerButton];
    [self.costomerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(42);
        make.centerX.mas_equalTo(self.backToTopButton.centerX).offset(1.5);
        make.bottom.mas_equalTo(self.backToTopButton.top).offset(-5);
    }];
    self.costomerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSString *service_phone = ServicePhone;
        NSString *text = [[NSString alloc] initWithFormat:@"telprompt://%@", service_phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
        return [RACSignal empty];
    }];
    self.backToTopButton.hidden = YES;
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType)
        {
            case HomeViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case HomeViewModel_GetDataSuccess:
            {
                // 获取数据成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView.mainTable reloadData];
                [self.mainView.mainTable.mj_header endRefreshing];
            }
                break;
            case HomeViewModel_GetDataFail:
            {
                // 获取数据失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.mainView.mainTable.mj_header.state == MJRefreshStateRefreshing || self.mainView.mainTable.mj_footer.state == MJRefreshStateRefreshing) {
                    [self.mainView.mainTable.mj_header endRefreshing];
                    [self.mainView.mainTable.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }else{
                    [self.view DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData];
                    } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
                }
            }
                break;
            case HomeViewModel_GetProductsSuccess:
            {
                // 获取商品列表成功
                [self.mainView.mainTable reloadData];
                NSArray *array = x;
                if (array.count % PageGetDataNumber || array.count == self.viewModel.oldDataCount) {
                    [self.mainView.mainTable.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mainView.mainTable.mj_footer endRefreshing];
                }
                self.viewModel.oldDataCount = array.count;
            }
                break;
            case HomeViewModel_GetProductsFailed:
            {
                // 获取商品列表失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.mainView.mainTable.mj_header.state == MJRefreshStateRefreshing || self.mainView.mainTable.mj_footer.state == MJRefreshStateRefreshing) {
                    [self.mainView.mainTable.mj_header endRefreshing];
                    [self.mainView.mainTable.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }
            }
                break;
            
            case HomeViewModel_GotoSecKillList:
            {
                // 跳转秒杀列表
                SecKillListViewController *vc = [SecKillListViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HomeViewModel_GotoGroupBuyList:
            {
                // 跳转拼团列表
                GroupBuyListViewController *vc = [GroupBuyListViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HomeViewModel_GotoBargainList:
            {
                // 跳转砍价列表
                BargainListViewController *vc = [BargainListViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HomeViewModel_GotoGoodsDetail:
            {
                // 跳转商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HomeViewModel_GotoProductList:
            {
                // 跳转商品列表
                ProductListViewController *vc = [ProductListViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HomeViewModel_GotoScoreGoods:
            {
                // 跳转积分商城
                [PublicEventManager changeToCategoryVCWithGoods_cat_type:@"1"
                                                            goods_cat_id:nil];
            }
                break;
                
            default:
                break;
        }
    }];
    
    // 监测偏移量确认要不要显示返回顶部
    [[RACObserve(self.mainView.mainTable,contentOffset) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if (self.mainView.mainTable.contentOffset.y>=(KScreenHeight-NAVIGATIONBAR_HEIGHT-TABLE_BAR_HEIGHT)*2) {
            self.backToTopButton.hidden = NO;
        }else{
            self.backToTopButton.hidden = YES;
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
