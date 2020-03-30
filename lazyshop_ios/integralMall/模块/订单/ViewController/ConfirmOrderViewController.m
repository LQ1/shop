//
//  ConfirmOrderViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderViewController.h"

#import "ConfirmOrderView.h"
#import "ConfirmOrderViewModel.h"

#import "ChoiceWareHouseViewController.h"
#import "CouponUseViewController.h"
#import "PaymentViewController.h"
#import "ShippingAddressSelectViewController.h"
#import "PayResultViewController.h"
#import "OrderDetailViewController.h"

@interface ConfirmOrderViewController ()

@property (nonatomic,strong)ConfirmOrderView *mainView;

@end

@implementation ConfirmOrderViewController

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
    self.navigationBarView.titleLabel.text = @"确认订单";
    self.navigationBarView.navagationBarStyle = Left_button_Show;
    // 主视图
    ConfirmOrderView *mainView = [ConfirmOrderView new];
    self.mainView = mainView;
    self.mainView.hidden = YES;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ConfirmOrderViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GetDataSuccess:
            {
                // 获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GetDataFailed:
            {
                // 获取数据失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                [self.view DLLoadingCycleInSelf:^{
                    @strongify(self);
                    [self getData];
                } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoWareHouse:
            {
                // 跳转选择取货仓
                ChoiceWareHouseViewController *vc = [ChoiceWareHouseViewController new];
                vc.viewModel = x;
                vc.selectSuccessBlock = ^(ChoiceWareHouseItemModel *wareHouseModel) {
                    @strongify(self);
                    [self choiceWareHouseWithModel:wareHouseModel];
                };
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoCouponUse:
            {
                // 使用优惠券
                CouponUseViewController *vc = [CouponUseViewController new];
                vc.viewModel = x;
                vc.useSuccessBlock = ^(RACTuple *tuple) {
                    @strongify(self);
                    self.viewModel.couponItemViewModel.currentUseCouponID = tuple.first;
                    [self.viewModel reloadTotalPriceWithOldCouponValue:self.viewModel.couponItemViewModel.currentMoneyValue newCouponValue:tuple.second];
                    self.viewModel.couponItemViewModel.currentMoneyValue = tuple.second;
                    [self.mainView reloadDataWithViewModel:self.viewModel];
                };
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoPaymentList:
            {
                // 跳转支付方式列表
                PaymentViewController *vc = [PaymentViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoAddressSelect:
            {
                // 跳转收货地址选择
                ShippingAddressSelectViewController *vc = [ShippingAddressSelectViewController new];
                vc.viewModel = x;
                vc.selectSuccessBlock = ^(ShippingAddressModel *addressModel) {
                    @strongify(self);
                    [self.viewModel resetAddressWithModel:addressModel];
                    [self.mainView reloadDataWithViewModel:self.viewModel];
                };
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoPayResult:
            {
                // 跳转支付结果
                PayResultViewController *vc = [PayResultViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ConfirmOrderViewModel_Signal_Type_GotoOrderDetail:
            {
                // 跳转订单详情
                OrderDetailViewController *vc = [OrderDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
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

// 选择货仓成功
- (void)choiceWareHouseWithModel:(ChoiceWareHouseItemModel *)wareHouseModel
{
    self.viewModel.wareHouseCellVM.wareHouseID = [NSString stringWithFormat:@"%ld",(long)wareHouseModel.storehouse_id];
    self.viewModel.wareHouseCellVM.wareHouseName = wareHouseModel.name;
    self.viewModel.wareHouseCellVM.sellerPost = wareHouseModel.sellerPost;
    [self.mainView reloadDataWithViewModel:self.viewModel];
}

- (void)leftButtonClick
{
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"确认要离开订单页面吗？"
                                                     titles:@[@"我再想想",@"去意已决"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              [super leftButtonClick];
                                                          }
                                                      }];
    [alert show];
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
