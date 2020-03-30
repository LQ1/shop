//
//  MineViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineViewController.h"

#import "MineView.h"
#import "MineViewModel.h"

#import "MyOrdersViewController.h"
#import "ShippingAddressManageViewController.h"
#import "SettingViewController.h"
#import "MyScoreViewController.h"
#import "ScoreSignInViewController.h"
#import "RelateStoreViewController.h"
#import "CashBackViewController.h"
#import "MyCouponsViewController.h"
#import "MyBargainViewController.h"
#import "MyGroupBuyViewController.h"
#import "PersonalMessageViewController.h"
#import "CommentCenterListViewController.h"

@interface MineViewController ()

@property (nonatomic,strong)MineView *mainView;
@property (nonatomic,strong)MineViewModel *viewModel;

@end

@implementation MineViewController

- (void)viewDidLoad
{
    self.viewModel = [MineViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.viewModel getBaseUserData];
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"我";
    // 主视图
    self.mainView = [MineView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:YES];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MineViewModel_Signal_Type_GotoMyOrders:
            {
                // 跳转我的订单
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    MyOrdersViewController *vc = [MyOrdersViewController new];
                    vc.viewModel = x;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoAddressManage:
            {
                // 跳转收货地址管理
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    ShippingAddressManageViewController *vc = [ShippingAddressManageViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoSetting:
            {
                // 跳转设置
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    SettingViewController *vc = [SettingViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoConnect:
            {
                // 跳转联系我们
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    [PublicEventManager pushLawProtocolViewControllerWithContentID:@"21"];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoBuyTip:
            {
                // 跳转购物须知
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    [PublicEventManager pushLawProtocolViewControllerWithContentID:@"19"];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoPostTip:
            {
                // 跳转配送说明
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    [PublicEventManager pushLawProtocolViewControllerWithContentID:@"20"];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoAfterBuyTip:
            {
                // 跳转售后说明
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    [PublicEventManager pushLawProtocolViewControllerWithContentID:@"22"];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoMyScore:
            {
                // 跳转我的积分
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    MyScoreViewController *vc = [MyScoreViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoScoreSignIn:
            {
                // 跳转积分签到
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    ScoreSignInViewController *vc = [ScoreSignInViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoRelateStore:
            {
                // 跳转关联店铺
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    RelateStoreViewController *vc = [RelateStoreViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoCashBack:
            {
                // 跳转返利列表
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    CashBackViewController *vc = [CashBackViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoMyCoupons:
            {
                // 跳转优惠券
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    MyCouponsViewController *vc = [MyCouponsViewController new];
                    vc.viewModel = x;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoPersonalMessage:
            {
                // 跳转个人资料
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    PersonalMessageViewController *vc = [PersonalMessageViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoMyGroupBuy:
            {
                // 跳转我的拼团
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    MyGroupBuyViewController *vc = [MyGroupBuyViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoMyBargain:
            {
                // 跳转我的砍价
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    MyBargainViewController *vc = [MyBargainViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_GotoCommentCenter:
            {
                // 跳转评价中心
                [PublicEventManager judgeLoginToPushWithNavigationController:self.navigationController pushBlock:^{
                    @strongify(self);
                    CommentCenterListViewController *vc = [CommentCenterListViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
                break;
            case MineViewModel_Signal_Type_ReloadView:
            {
                // 刷新视图显示
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
                
            default:
                break;
        }
    }];
    // 观察登录状态
    [[RACObserve([AccountService shareInstance], isLogin) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
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
