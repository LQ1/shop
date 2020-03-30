//
//  SecKillListPageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListPageView.h"

#import "SecKillListPageViewModel.h"
#import "SecKillListItemCell.h"

static NSString *cellReuseID = @"SecKillListItemCell";

@interface SecKillListPageView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SecKillListPageView

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
    
    [mainTable registerClass:[SecKillListItemCell class] forCellReuseIdentifier:cellReuseID];
    // 下拉刷新
    [self setCurrentRefreshType:AT_ALL_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = PageGetDataNumber;
    @weakify(self);
    [self getRefreshTableData:^{
        @strongify(self);
        [self getData:YES];
    }];
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self getData:NO];
    }];
}

- (void)getData:(BOOL)refresh
{
    [self.viewModel getDataRefresh:refresh];
}

#pragma mark -list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ProductRowBaseCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecKillListItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoGoodsDetailAtIndexPath:indexPath];
    }];
    return cell;
}

@end
