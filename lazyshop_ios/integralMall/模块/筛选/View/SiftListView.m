//
//  SiftListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListView.h"

#import "SiftListViewModel.h"
#import "IntegralSiftListHeaderView.h"
#import "LYListBottomView.h"
#import "SiftListSectionView.h"
#import "SiftListItemCell.h"

static NSString *sectionReuseID = @"SiftListSectionView";
static NSString *cellReuseID = @"SiftListItemCell";

@interface SiftListView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)SiftListViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)IntegralSiftListHeaderView *headerView;

@end

@implementation SiftListView

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
    // 头视图
    IntegralSiftListHeaderView *headerView = [IntegralSiftListHeaderView new];
    self.headerView = headerView;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(IntegralSiftListHeaderViewBaseHeight);
    }];
    @weakify(self);
    [headerView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self clearAllRowsSelected];
        [self reloadDataWithViewModel:self.viewModel];
    }];
    
    // 尾视图
    LYListBottomView *bottomView = [[LYListBottomView alloc] initWithTitles:@[@"清空筛选",@"完成"]
                                                           backColorStrings:@[@"#ffffff",APP_MainColor]
                                                        textColorStrings:@[@"#000000",@"#ffffff"]
                                                                    leftPro:295./670.
                                                                 clickBlock:^(int clickIndex) {
                                                                     @strongify(self);
                                                                     if (clickIndex == 0) {
                                                                         [self clearAllRowsSelected];
                                                                         [self reloadDataWithViewModel:self.viewModel];
                                                                     }else{
                                                                         [self.headerView endInputEditting];
                                                                         [self.viewModel completeSift];
                                                                         [DLAlertShowAnimate disappear];
                                                                     }
                                                                 }];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
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
        make.top.mas_equalTo(headerView.bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.top);
    }];
    [mainTable registerClass:[SiftListSectionView class] forHeaderFooterViewReuseIdentifier:sectionReuseID];
    [mainTable registerClass:[SiftListItemCell class] forCellReuseIdentifier:cellReuseID];
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
    SiftListSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionReuseID];
    @weakify(self);
    [[sectionView.clickSignal takeUntil:sectionView.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel clickHeaderInSection:section];
        [self.mainTable reloadData];
    }];
    [sectionView bindViewModel:[self.viewModel viewModelForHeaderInSection:section]];
    return sectionView;
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
    SiftListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
    [self reloadDataWithViewModel:self.viewModel];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(SiftListViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.headerView.headerHeight);
    }];
}

#pragma mark -私有
// 清空筛选
- (void)clearAllRowsSelected
{
    [self.viewModel clearAllRowsSelected];
    [self.headerView endInputEditting];
}

@end
