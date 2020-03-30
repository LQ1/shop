//
//  ProductListViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListViewController.h"

#import "MJRefresh.h"

#import "ProductSearchNavView.h"
#import "ProductListViewModel.h"
#import "ProductListView.h"
#import "GoodsDetailViewController.h"
#import "SiftListViewController.h"
#import "ProductSearchViewController.h"

@interface ProductListViewController ()

@property (nonatomic,strong)ProductListView *mainView;
@property (nonatomic,strong)ProductSearchNavView *searchView;

@end

@implementation ProductListViewController

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
        // 去除搜索视图
        NSMutableArray *vcS = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        UIViewController *tobeRemoveVC = nil;
        for (UIViewController *vc in vcS) {
            if ([vc isKindOfClass:[ProductSearchViewController class]]) {
                tobeRemoveVC = vc;
            }
        }
        [vcS removeObject:tobeRemoveVC];
        self.navigationController.viewControllers = [NSArray arrayWithArray:vcS];
    }
}

// 获取数据
- (void)getData
{
    [self.mainView setListHidden:YES];
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    // 导航
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    [self.navigationBarView.rightButton setImage:[self.viewModel fetchRightNavImage] forState:UIControlStateNormal];
    // 搜索框
    @weakify(self);
    ProductSearchNavView *searchView = [[ProductSearchNavView alloc] initWithInputEnabled:NO tipTitle:@"爆款商品随便搜" ProductSearchFrom:ProductSearchFrom_ProductList searchTitleBackBlock:^(NSString *searchTitle){
        @strongify(self);
        self.viewModel.goods_title = searchTitle;
        [self getData];
    }];
    self.searchView = searchView;
    if (self.viewModel.goods_title.length) {
        self.searchView.searchTipLabel.text = self.viewModel.goods_title;
    }
    [self.navigationBarView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-48);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self.navigationBarView).offset(10);
    }];
    
    // 主视图
    ProductListView *mainView = [[ProductListView alloc] initWithViewModel:self.viewModel];
    self.mainView = mainView;
    [self.mainView setListHidden:YES];
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)rightButtonClick
{
    [self.viewModel revalListStyle];
    [self.navigationBarView.rightButton setImage:[self.viewModel fetchRightNavImage] forState:UIControlStateNormal];
    [self.mainView reloadDataWithViewModel:self.viewModel];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ProductListViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case ProductListViewModel_Signal_Type_LoadingInView:
            {
                // loading
                [self.view DLLoadingInSelf];
            }
                break;
            case ProductListViewModel_Signal_Type_GetDataSuccess:
            {
                NSArray *array = x;
                if (array.count == 0) {
                    [self.view DLLoadingCustomInSelf:@"无商品信息"
                                                code:DLDataEmpty
                                               title:@"没搜索到匹配商品"
                                               cycle:^{
                                                   @strongify(self);
                                                   [self getData];
                                               }
                                         buttonTitle:LOAD_FAILED_RETRY];
                }else{
                    // 获取成功
                    [self.mainView setListHidden:NO];
                    [self.view DLLoadingHideInSelf];
                    [self.mainView reloadDataWithViewModel:self.viewModel];
                }
            }
                break;
            case ProductListViewModel_Signal_Type_GetDataFail:
            {
                // 获取数据失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.mainView.gridListView.mainCollectionView.mj_header.state == MJRefreshStateRefreshing || self.mainView.gridListView.mainCollectionView.mj_footer.state == MJRefreshStateRefreshing) {
                    [self.mainView.gridListView.mainCollectionView.mj_header endRefreshing];
                    [self.mainView.gridListView.mainCollectionView.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }else if (self.mainView.horiListView.mainTable.mj_header.state == MJRefreshStateRefreshing || self.mainView.horiListView.mainTable.mj_footer.state == MJRefreshStateRefreshing) {
                    [self.mainView.horiListView.mainTable.mj_header endRefreshing];
                    [self.mainView.horiListView.mainTable.mj_footer endRefreshing];
                    [DLLoading DLToolTipInWindow:title];
                }else{
                    [self.view DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData];
                    } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
                }
            }
                break;
            case ProductListViewModel_Signal_Type_GotoGoodsDetail:
            {
                // 跳转商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
                vc.propertyIsEnterFromMakeMoney = self.propertyIsEnterFromMakeMoney;
                vc.viewModel = x;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ProductListViewModel_Signal_Type_ShowSift:
            {
                // 展示筛选
                SiftListViewController *vc = [SiftListViewController new];
                [vc setSiftCompleteBlock:^(NSString *goods_cart_id, NSString *min_score, NSString *max_store) {
                    @strongify(self);
                    // 刷新数据
                    self.viewModel.goods_cat_id = [NSNumber numberWithInteger:[goods_cart_id integerValue]];
                    self.viewModel.min_score = min_score.length ? [NSNumber numberWithInteger:[min_score integerValue]]:nil;
                    self.viewModel.max_score = max_store.length ? [NSNumber numberWithInteger:[max_store integerValue]]:nil;
                    [self getData];
                }];
                vc.viewModel = x;
                vc.view.frame = CGRectMake(1./8.*KScreenWidth, 0, 7./8.*KScreenWidth, KScreenHeight);
                [self addChildViewController:vc];
                [DLAlertShowAnimate showInView:self.view
                                     alertView:vc.view
                                     popupMode:View_Popup_Mode_Right
                                       bgAlpha:.5
                              outsideDisappear:YES];
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
