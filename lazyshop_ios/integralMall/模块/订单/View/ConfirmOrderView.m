//
//  ConfirmOrderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderView.h"

#import "ConfirmOrderViewModel.h"
#import "ConfirmOrderHeadAdressView.h"
#import "ConfirmOrderListBottomView.h"

#import "LYSectionGrayBarView.h"
#import "LYItemUIBaseCell.h"
#import "LYItemUIBaseViewModel.h"

static NSString *sectionReuseID = @"LYSectionGrayBarView";

@interface ConfirmOrderView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)ConfirmOrderViewModel *viewModel;

@property (nonatomic,strong)ConfirmOrderHeadAdressView *headerView;
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)ConfirmOrderListBottomView *bottomView;


@end

@implementation ConfirmOrderView

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
    // header
    self.headerView = [[ConfirmOrderHeadAdressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, ConfirmOrderHeadAdressViewHeight)];
    @weakify(self);
    [self.headerView.clickSignal subscribeNext:^(id x) {
       @strongify(self);
        [self selectShippingAddress];
    }];
    
    // bottom
    self.bottomView = [ConfirmOrderListBottomView new];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(ConfirmOrderListBottomViewHeight);
        make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
    }];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.top);
    }];
    self.mainTable.tableHeaderView = self.headerView;
    
    [mainTable registerClass:[LYSectionGrayBarView class] forHeaderFooterViewReuseIdentifier:sectionReuseID];
}

// 选择收货地址
- (void)selectShippingAddress
{
    [self.viewModel selectShippingAddress];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ConfirmOrderViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.bottomView reloadDataWithViewModel:viewModel];
}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LYSectionGrayBarView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionReuseID];
    return header;
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
    LYItemUIBaseViewModel *vm = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    LYItemUIBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:vm.UIReuseID];
    if (!cell) {
        cell = [[NSClassFromString(vm.UIClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vm.UIReuseID];
    }
    [cell bindViewModel:vm];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
