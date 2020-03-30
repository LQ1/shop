//
//  ScoreMessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ScoreMessageViewController.h"

#import "ScoreMessageViewModel.h"
#import "ScoreMessageView.h"

@interface ScoreMessageViewController ()

@property (nonatomic,strong)ScoreMessageViewModel *viewModel;
@property (nonatomic,strong)ScoreMessageView *mainView;
@property (nonatomic,copy)NSString *loadingFailedImageName;

@end

@implementation ScoreMessageViewController

- (void)viewDidLoad
{
    self.viewModel = [ScoreMessageViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
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
    [self.viewModel getData:YES];
}

// 添加视图
- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"积分消息";
    self.loadingFailedImageName = @"没有此类消息";
    self.mainView = [ScoreMessageView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

// 信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.tipLoadingSignal subscribeNext:^(id x) {
        [DLLoading DLToolTipInWindow:x];
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
    
    [self.viewModel.fetchListSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取成功
        self.mainView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        [self.mainView reloadDataWithViewModel:self.viewModel];
    }];
    
    [self.viewModel.fetchListFailedSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取数据失败
        self.mainView.hidden = YES;
        NSError *error = x;
        NSString *title = AppErrorParsing(error);
        if (self.loadingFailedImageName.length) {
            [self.view DLLoadingCustomInSelf:self.loadingFailedImageName
              code:error.code
                                        title:title
                                       cycle:^{
                                           @strongify(self);
                                           [self getData];
                                       }
                                 buttonTitle:LOAD_FAILED_RETRY];
        }else{
            [self.view DLLoadingCycleInSelf:^{
                @strongify(self);
                [self getData];
            } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
        }
    }];
    
    [self.viewModel.reloadViewSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取成功
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
