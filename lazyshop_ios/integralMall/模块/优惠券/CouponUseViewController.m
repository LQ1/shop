//
//  CouponUseViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponUseViewController.h"

#import "CouponUseViewModel.h"
#import "CouponUseView.h"

@interface CouponUseViewController ()

@property (nonatomic,strong)CouponUseView *mainView;

@end

@implementation CouponUseViewController

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
    self.navigationBarView.titleLabel.text = @"选择优惠券";
    self.navigationBarView.navagationBarStyle = Left_button_Show;
    // 主视图
    CouponUseView *mainView = [CouponUseView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case CouponUseViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case CouponUseViewModel_Signal_Type_GetDataSuccess:
            {
                // 获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case CouponUseViewModel_Signal_Type_GetDataFailed:
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
            case CouponUseViewModel_Signal_Type_ReloadData:
            {
                // 刷新
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case CouponUseViewModel_Signal_Type_UseCouponSuccess:
            {
                // 使用优惠券成功
                if (self.useSuccessBlock) {
                    self.useSuccessBlock(x);
                }
                [self leftButtonClick];
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
