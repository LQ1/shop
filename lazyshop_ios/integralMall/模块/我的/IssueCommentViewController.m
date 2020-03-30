//
//  IssueCommentViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "IssueCommentViewController.h"

#import "IssueCommentViewModel.h"
#import "IssueCommentView.h"

#define IMG_SIZE                    1000

@interface IssueCommentViewController ()

@property (nonatomic,strong)IssueCommentView *mainView;
@property (nonatomic, copy) issueCommentSuccess mySuccessBlock;

@end

@implementation IssueCommentViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mainView closeVC];
}

- (void)viewDidLoad
{
    self.closeInteractiveGesture = YES;
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
}

- (void)leftButtonClick
{
    [self.mainView closeVC];
    if ([self.mainView hasContentInput]) {
        LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                        message:@"确认放弃评价"
                                                         titles:@[@"我再想想",@"确认"] click:^(NSInteger index) {
                                                             if (index == 1) {
                                                                 [super leftButtonClick];
                                                             }
                                                         }];
        [alert show];
    }else{
        [super leftButtonClick];
    }
}

#pragma mark -主界面
- (void)addViews
{
    self.navigationBarView.titleLabel.text = @"发表评价";
    self.mainView = [[IssueCommentView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

#pragma mark -bind
- (void)bindSignal
{
    // 选择图片
    @weakify(self);
    self.mainView.selectImg = ^(void){
        @strongify(self);
        //选择图片
        NSInteger count = 3 - self.mainView.imgs.count;
        
        [self initWithTakePhoneActionSheet:YES maxNumber:count maxKb:IMG_SIZE];
        [self setImageArrayBlock:^(NSMutableArray *imageArray) {
            @strongify(self);
            [self loadPics:imageArray];
        }];
    };
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
    // 提交评价成功
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [DLLoading DLToolTipInWindow:@"评价成功"];
        if (self.commentSuccessBlock) {
            self.commentSuccessBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark -私有
// 设置图片
- (void)loadPics:(NSArray *)imgs
{
    if (imgs.count) {
        [self.mainView.imgs addObjectsFromArray:imgs];
    }
    [self.mainView setImgZone];
}

#pragma mark -设置评价成功的回调
- (void)setDyAskBlock:(issueCommentSuccess)block;
{
    self.mySuccessBlock = block;
}


@end
