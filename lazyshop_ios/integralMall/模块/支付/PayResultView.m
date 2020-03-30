//
//  PayResultView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PayResultView.h"

#import "PayResultHeaderView.h"
#import "PayResultViewModel.h"
#import "HomeChosenCell.h"
#import "HomeChosenCellViewModel.h"

#import "LYRefreshFooter.h"

@interface PayResultView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PayResultHeaderView *headerView;
@property (nonatomic, strong) PayResultViewModel *viewModel;
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation PayResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.headerView = [[PayResultHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, PayResultHeaderViewHeight)];
    self.mainTable.tableHeaderView = self.headerView;
    
    // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
    [self.mainTable closeSelfClassSizing];

    // 上拉刷新
    @weakify(self);
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel getData:NO];
    }];
    self.mainTable.mj_footer = footer;
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(PayResultViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.mainTable reloadData];
}

#pragma mark -tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeChosenCellViewModel *cellVM = [self.viewModel cellVMForRowAtIndexPath:indexPath];
    return [cellVM UIHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeChosenCellViewModel *cellVM = [self.viewModel cellVMForRowAtIndexPath:indexPath];
    HomeChosenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellVM.UIReuseID];
    if (!cell) {
        cell = [[HomeChosenCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellVM.UIReuseID];
    }
    [cell bindViewModel:cellVM];
    @weakify(self);
    [[cell.baseClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoGoodsDetailWithVM:x];
    }];
    return cell;
}

@end
