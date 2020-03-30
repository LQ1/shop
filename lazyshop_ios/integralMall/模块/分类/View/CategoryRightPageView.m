//
//  CategoryRightPageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryRightPageView.h"

#import "CategoryFirstItemViewModel.h"
#import "CategoryRightHeaderView.h"
#import "CategoryRightRowCell.h"

static NSString *headerReuseID = @"CategoryRightHeaderView";
static NSString *cellReuseID = @"CategoryRightRowCell";

@interface CategoryRightPageView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)CategoryFirstItemViewModel *viewModel;

@end

@implementation CategoryRightPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gotoProductListSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoProductListSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
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
    [mainTable registerClass:[CategoryRightHeaderView class] forHeaderFooterViewReuseIdentifier:headerReuseID];
    [mainTable registerClass:[CategoryRightRowCell class] forCellReuseIdentifier:cellReuseID];
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(CategoryFirstItemViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.viewModel heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategoryRightHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseID];
    [view reloadDataWithViewModel:[self.viewModel secondItemVMInSection:section]];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryRightRowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID forIndexPath:indexPath];
    [cell reloadDataWithViewModel:[self.viewModel viewModelForRowAtIndexPath:indexPath]];
    // 跳转商品列表
    @weakify(self);
    [[cell.gotoProductListSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.gotoProductListSignal sendNext:x];
    }];
    return cell;
}

@end
