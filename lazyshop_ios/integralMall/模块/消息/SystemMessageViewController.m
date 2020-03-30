//
//  SystemMessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SystemMessageViewController.h"

#import "SystemMessageViewModel.h"
#import "SystemMessageView.h"

@interface SystemMessageViewController ()

@end

@implementation SystemMessageViewController

- (void)viewDidLoad
{
    self.viewModel = [SystemMessageViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"平台消息";
    self.loadingFailedImageName = @"没有此类消息";
    self.mainView = [SystemMessageView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
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
