//
//  ScoreSignInViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInViewController.h"

#import "ScoreSignInView.h"
#import "ScoreSignInViewModel.h"

@interface ScoreSignInViewController ()

@end

@implementation ScoreSignInViewController

- (void)viewDidLoad
{
    self.viewModel = [ScoreSignInViewModel new];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getData];
}

#pragma mark -UI
- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"积分签到";
    // mainView
    self.mainView = [ScoreSignInView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    self.mainView.hidden = YES;
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
