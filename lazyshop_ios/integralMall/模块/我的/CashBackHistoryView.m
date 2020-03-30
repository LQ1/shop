//
//  CashBackHistoryView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackHistoryView.h"

#import "CashBackHistoryViewModel.h"

#import "CashBackItemCell.h"

static NSString *cellReuseID = @"CashBackItemCell";

@interface CashBackHistoryView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CashBackHistoryViewModel *viewModel;

@end


@implementation CashBackHistoryView

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
    self.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    // 列表
    UITableView *mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[CashBackItemCell class] forCellReuseIdentifier:cellReuseID];
    
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
// 获取数据
- (void)getData:(BOOL)refresh
{
    [self.viewModel getData:refresh];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(CashBackHistoryViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.autoDataArray = viewModel.dataArray;
}

#pragma mark -table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CashBackItemCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashBackItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

@end
