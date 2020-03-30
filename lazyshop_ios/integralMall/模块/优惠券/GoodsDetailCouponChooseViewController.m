//
//  GoodsDetailCouponChooseViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCouponChooseViewController.h"

#import "GoodsDetailCouponChooseViewModel.h"
#import "GoodsDetailCouponChooseView.h"

@interface GoodsDetailCouponChooseViewController ()

@property (nonatomic,strong)GoodsDetailCouponChooseView *mainView;

@end

@implementation GoodsDetailCouponChooseViewController

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

#pragma mark -主界面
- (void)addViews
{
    GoodsDetailCouponChooseView *mainView = [GoodsDetailCouponChooseView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case GoodsDetailCouponChooseViewModel_Signal_Type_GetDataSuccess:
            {
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case GoodsDetailCouponChooseViewModel_Signal_Type_GetDataFail:
            {
                NSError *error = x;
                [self.view DLLoadingCycleInSelf:^{
                    @strongify(self);
                    [self getData];
                } code:error.code title:AppErrorParsing(error) buttonTitle:LOAD_FAILED_RETRY];
            }
                break;
            case GoodsDetailCouponChooseViewModel_Signal_Type_ReceiveSuccess:
            {
                // 领取优惠券成功
                [DLLoading DLToolTipInWindow:@"领取成功"];
                [DLAlertShowAnimate disappear];
            }
                break;
            case GoodsDetailCouponChooseViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
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
