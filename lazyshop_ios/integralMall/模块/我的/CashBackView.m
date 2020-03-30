//
//  CashBackView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackView.h"

#import "CashBackViewModel.h"

#import "CashBackItemCell.h"
#import "CashBackHeaderView.h"
#import "CashBackFooterView.h"

static NSString *cellReuseID = @"CashBackItemCell";
static NSString *headReuseID = @"CashBackHeaderView";
static NSString *footReuseID = @"CashBackFooterView";

@interface CashBackView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CashBackViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation CashBackView

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
    [mainTable registerClass:[CashBackHeaderView class] forHeaderFooterViewReuseIdentifier:headReuseID];
    [mainTable registerClass:[CashBackFooterView class] forHeaderFooterViewReuseIdentifier:footReuseID];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(CashBackViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CashBackHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CashBackHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headReuseID];
    [header bindViewModel:[self.viewModel sectionViewModelInSection:section]];
    @weakify(self);
    [[header.gotoOrderDetailSignal takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoOrderDetailWithVM:x];
    }];
    [[header.gotoBindShopSignal takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoBindShopWithVM:x];
    }];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CashBackFooterViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CashBackFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footReuseID];
    [footer bindViewModel:[self.viewModel sectionViewModelInSection:section]];
    @weakify(self);
    [[footer.clickSignal takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel clickFooterInSection:section];
        [self.mainTable reloadData];
    }];
    return footer;
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
    CashBackItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

@end
