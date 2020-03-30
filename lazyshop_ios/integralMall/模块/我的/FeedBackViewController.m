//
//  FeedBackViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackViewController.h"

#import "FeedBackView.h"
#import "FeedBackViewModel.h"

@interface FeedBackViewController ()

@property (nonatomic,strong)FeedBackView *mainView;
@property (nonatomic,strong)FeedBackViewModel *viewModel;

@end

@implementation FeedBackViewController

- (void)viewDidLoad
{
    self.viewModel = [FeedBackViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"功能反馈";
    
    self.mainView = [[FeedBackView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    // 监测loading状态
    @weakify(self);
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
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [DLLoading DLToolTipInWindow:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.viewModel.errorSignal subscribeNext:^(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
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
