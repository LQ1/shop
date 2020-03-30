//
//  PaymentViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentViewController.h"

#import "PaymentView.h"
#import "PaymentViewModel.h"

#import "PayResultViewController.h"

#import "OrderDetailViewController.h"

@interface PaymentViewController ()

@property (nonatomic,strong)PaymentView *mainView;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    self.viewModel.unionPayViewController = self;
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

#pragma mark -ui
- (void)addViews
{
    self.navigationBarView.navagationBarStyle = Left_button_Show;
    self.navigationBarView.titleLabel.text = @"懒店收银台";
    
    PaymentView *mainView = [PaymentView new];
    self.mainView = mainView;  
    [mainView realodDataWithViewModel:self.viewModel];
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
    
    self.mainView.hidden = YES;
}

#pragma mark -signal
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case PaymentViewModel_Signal_Type_TipLoading:
            {
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case PaymentViewModel_Signal_Type_GetDataSuccess:
            {
                self.mainView.hidden = NO;
                [self.mainView realodDataWithViewModel:self.viewModel];
                [self.view DLLoadingHideInSelf];
            }
                break;
            case PaymentViewModel_Signal_Type_GetDataFailed:
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
            case PaymentViewModel_Signal_Type_GotoPayResult:
            {
                // 跳转支付结果
                PayResultViewController *vc = [PayResultViewController new];
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

#pragma mark -返回
- (void)leftButtonClick
{
    @weakify(self);
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"确认要离开收银台吗"
                                                     titles:@[@"继续支付",@"确认离开"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              @strongify(self);
                                                              [self leavePayment];
                                                          }
                                                      }];
    [alert show];
}
// 确认离开
- (void)leavePayment
{
    __block BOOL exsitOrderDetail = NO;
    __block NSInteger orderDetailIndex = 0;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OrderDetailViewController class]]) {
            exsitOrderDetail = YES;
            orderDetailIndex = idx;
        }
    }];
    if (exsitOrderDetail) {
        // 当前导航中有订单详情 pop到订单详情
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:orderDetailIndex] animated:YES];
    }else{
        // 当前导航中没有订单详情 push到订单详情 且移除之前导航内vcs
        OrderDetailViewController *vc = [OrderDetailViewController new];
        vc.viewModel = [self.viewModel fetchRootPopOrderDetailVM];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
