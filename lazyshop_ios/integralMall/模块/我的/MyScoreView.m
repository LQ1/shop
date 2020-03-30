//
//  MyScoreView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreView.h"

#import "MyScoreViewModel.h"
#import "MyScoreHeaderView.h"
#import "MyScoreDetailView.h"

@interface MyScoreView()

@property (nonatomic, strong) MyScoreDetailView *detailView;
@property (nonatomic, strong) MyScoreHeaderView *headerView;
@property (nonatomic, strong) MyScoreViewModel *viewModel;

@end

@implementation MyScoreView

- (instancetype)initWithViewModel:(MyScoreViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        [self bindSignal];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // back
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // header
    self.headerView = [MyScoreHeaderView new];
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MyScoreHeaderViewHeight);
    }];
    // detail
    self.detailView = [[MyScoreDetailView alloc] initWithViewModel:self.viewModel];
    [self addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.bottom).offset(5);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark -bindSignal
- (void)bindSignal
{
    @weakify(self);
    [self.headerView.gotoSignSingal subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoSignalVC];
    }];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(MyScoreViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.detailView getDataMore:NO];
}

@end
