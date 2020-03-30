//
//  CommentCenterListViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterListViewController.h"

#import "CommentCenterListViewModel.h"
#import "CommentCenterListView.h"

#import "OrderCommentDetailViewController.h"
#import "IssueCommentViewController.h"

@interface CommentCenterListViewController ()

@property (nonatomic,strong)CommentCenterListViewModel *viewModel;
@property (nonatomic,strong)CommentCenterListView *mainView;

@end

@implementation CommentCenterListViewController

- (void)viewDidLoad
{
    self.viewModel = [CommentCenterListViewModel new];
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

#pragma mark -主界面
- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"评价中心";
    self.mainView = [[CommentCenterListView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

#pragma mark -bind
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case CommentCenterListViewModell_Signal_Type_GotoCommentDetail:
            {
                // 评价详情
                OrderCommentDetailViewController *vc = [OrderCommentDetailViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case CommentCenterListViewModell_Signal_Type_GotoSendComment:
            {
                // 发表评价
                IssueCommentViewController *vc = [IssueCommentViewController new];
                vc.commentSuccessBlock = ^{
                    @strongify(self);
                    [self.mainView autoPullGetData];
                };
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
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
