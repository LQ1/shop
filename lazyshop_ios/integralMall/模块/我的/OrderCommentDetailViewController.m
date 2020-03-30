//
//  OrderCommentDetailViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderCommentDetailViewController.h"

#import "CommentListViewModel.h"
#import "CommentListView.h"

@interface OrderCommentDetailViewController ()

@property (nonatomic,strong)CommentListView *mainView;

@end

@implementation OrderCommentDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
}

- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"评价详情";
    self.mainView = [CommentListView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    [self.mainView bindViewModel:self.viewModel];
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
