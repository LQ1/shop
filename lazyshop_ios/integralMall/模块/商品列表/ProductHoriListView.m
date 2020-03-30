//
//  ProductHoriListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductHoriListView.h"

#import "ProductHoriListCell.h"
#import "ProductListViewModel.h"

#import "LYRefreshHeader.h"
#import "LYRefreshFooter.h"

static NSString *cellReuseID = @"ProductHoriListCell";

@interface ProductHoriListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)ProductListViewModel *viewModel;

@end

@implementation ProductHoriListView

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
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [mainTable registerClass:[ProductHoriListCell class] forCellReuseIdentifier:cellReuseID];
    
    // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
    [self.mainTable closeSelfClassSizing];

    @weakify(self);
    // 下拉刷新
    LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData:YES];
    }];
    self.mainTable.mj_header = header;
    
    // 上拉刷新
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getData:NO];
    }];
    self.mainTable.mj_footer = footer;
}

- (void)getData:(BOOL)refresh
{
    if (refresh) {
        [self.viewModel getData];
    }else{
        [self.viewModel getMoreData];
    }
}

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
    [self.mainTable.mj_header endRefreshing];
    if (viewModel.dataArray.count % PageGetDataNumber || viewModel.dataArray.count == self.viewModel.oldDataCount) {
        [self.mainTable.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mainTable.mj_footer endRefreshing];
    }
    self.viewModel.oldDataCount = viewModel.dataArray.count;
}

#pragma mark -tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ProductHoriListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductHoriListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellVMForItemAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectItemAtIndexPath:indexPath];
}

@end
