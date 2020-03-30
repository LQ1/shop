//
//  ShoppingCartViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartViewController.h"

#import "MJRefresh.h"
#import "ShoppingCartView.h"
#import "ShoppingCartViewModel.h"

#import "ConfirmOrderViewController.h"
#import "GoodsDetailViewController.h"

@interface ShoppingCartViewController ()

@property (nonatomic,strong)ShoppingCartView *mainView;
@property (nonatomic,strong)ShoppingCartViewModel *viewModel;
@property (nonatomic,strong)UIButton *editButton;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [ShoppingCartViewModel new];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getData];
}

// 获取数据
- (void)getData
{
    self.mainView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 导航
    self.navigationBarView.titleLabel.text = @"购物车";
    if (self.usedForPush) {
        self.navigationBarView.navagationBarStyle = Left_right_button_show;
    }else{
        self.navigationBarView.navagationBarStyle = Right_button_show;
    }
    
    self.navigationBarView.rightButton.enabled = NO;
    UIButton *messageBtn = [[PublicEventManager shareInstance] fetchMessageButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.navigationBarView).offset(10);
        make.centerX.mas_equalTo(self.navigationBarView.right).offset(-24);
    }];
    
    UIButton *editButton = [UIButton new];
    self.editButton = editButton;
    editButton.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.navigationBarView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.navigationBarView.rightButton.left);
        make.centerY.mas_equalTo(self.navigationBarView.rightButton);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(25);
    }];
    @weakify(self);
    editButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel revalEditing];
        if (self.viewModel.editting) {
            [editButton setTitle:@"完成" forState:UIControlStateNormal];
        }else{
            [editButton setTitle:@"编辑" forState:UIControlStateNormal];
        }
        return [RACSignal empty];
    }];
    
    // 主视图
    ShoppingCartView *mainView = [[ShoppingCartView alloc] initWithUsedForPush:self.usedForPush];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:!self.usedForPush];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ShoppingCartViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_GetCartListSuccess:
            {
                // 获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                if (self.viewModel.empty) {
                    self.editButton.hidden = YES;
                }else{
                    self.editButton.hidden = NO;
                }
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_GetCartListFailed:
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
            case ShoppingCartViewModel_Signal_Type_GetRecommentSuccess:
            {
                // 获取为你推荐成功
                [self.mainView reloadDataWithViewModel:self.viewModel];
                NSArray *array = x;
                if (array.count % PageGetDataNumber || array.count == self.viewModel.oldDataCount) {
                    [self.mainView.mainTable.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mainView.mainTable.mj_footer endRefreshing];
                }
                self.viewModel.oldDataCount = array.count;
            }
                break;
            case ShoppingCartViewModel_Signal_Type_GetRecommentFailed:
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
            case ShoppingCartViewModel_Signal_Type_NeedReloadView:
            {
                // 刷新view
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_GotoConfirmOrder:
            {
                // 确认订单
                ConfirmOrderViewController *vc = [ConfirmOrderViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_NeedPullToRefresh:
            {
                // 下拉刷新
                [self getData];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_NeedLogin:
            {
                self.editButton.hidden = YES;
                // 需要登录
                [self.view DLLoadingCycleInSelf:^{
                    @strongify(self);
                    self.hasAppeard = NO;
                    [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                        @strongify(self);
                        [self getData];
                    }];
                } code:DLDataFailed title:@"您还没有登录" buttonTitle:@"登录"];

            }
                break;
            case ShoppingCartViewModel_Signal_Type_GotoGoodsDetail:
            {
                // 跳转商品详情
                GoodsDetailViewController *vc = [GoodsDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ShoppingCartViewModel_Signal_Type_GotoHomePage:
            {
                // 跳转首页
                if (self.usedForPush) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [[[RACSignal interval:.66 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
                        [LYAppDelegate.tabBarController changeToTab:ClassTableBarType_HomePage];
                    }];
                }else{
                    [LYAppDelegate.tabBarController changeToTab:ClassTableBarType_HomePage];
                }
            }
                break;
                
            default:
                break;
        }
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
