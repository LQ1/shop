//
//  MyScoreViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreViewController.h"

#import "MyScoreViewModel.h"
#import "MyScoreView.h"

#import "ScoreSignInViewController.h"

@interface MyScoreViewController ()

@property (nonatomic, strong) MyScoreViewModel *viewModel;
@property (nonatomic, strong) MyScoreView *mainView;

@end

@implementation MyScoreViewController

- (void)viewDidLoad
{
    self.viewModel = [MyScoreViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getData];
}

- (void)getData
{
    self.mainView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"我的积分";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"积分说明";
    // 主页面
    self.mainView = [[MyScoreView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    self.mainView.hidden = YES;
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.fetchListSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        self.mainView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        [self.mainView reloadDataWithViewModel:self.viewModel];
    }];
    
    [self.viewModel.fetchListFailedSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取数据失败
        self.mainView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        [self.mainView reloadDataWithViewModel:self.viewModel];
        NSError *error = x;
        NSString *title = AppErrorParsing(error);
        [DLLoading DLToolTipInWindow:title];
    }];
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyScoreViewModel_Signal_Type_GotoSignalVC:
            {
                ScoreSignInViewController *vc = [ScoreSignInViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)rightButtonClick
{
    [PublicEventManager pushLawProtocolViewControllerWithContentID:@"18"];
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
