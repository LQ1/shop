//
//  GroupBuyListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GroupBuyListView.h"

#import "GroupBuyListViewModel.h"

#import "GroupBuyListItemCell.h"

static NSString *cellReuseID = @"GroupBuyListItemCell";

@interface GroupBuyListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)GroupBuyListViewModel *viewModel;

@end


@implementation GroupBuyListView

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
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    
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
    
    [mainTable registerClass:[GroupBuyListItemCell class] forCellReuseIdentifier:cellReuseID];
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
    [self.viewModel getData:refresh];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(GroupBuyListViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.autoDataArray = viewModel.dataArray;
}

#pragma mark -tableview delegate
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
    GroupBuyListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellVMForRowAtIndexPath:indexPath]];
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel didSelectRowAtIndexPath:indexPath];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
