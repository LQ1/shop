//
//  StoreDetailView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreDetailView.h"

#import "StoreDeailTextCell.h"
#import "StoreListItemCell.h"
#import "StoreDetailViewModel.h"
#import "StoreListItemViewModel.h"
#import "StoreDeailTextCellViewModel.h"

static NSString *listItemCellReuseID = @"StoreListItemCell";
static NSString *textCellReuseID = @"StoreDeailTextCell";

@interface StoreDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)StoreDetailViewModel *viewModel;

@end

@implementation StoreDetailView

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
    
    [mainTable registerClass:[StoreListItemCell class] forCellReuseIdentifier:listItemCellReuseID];
    [mainTable registerClass:[StoreDeailTextCell class] forCellReuseIdentifier:textCellReuseID];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(StoreDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
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
    LYItemUIBaseViewModel *vm = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    LYItemUIBaseCell *cell;
    if ([vm isKindOfClass:[StoreDeailTextCellViewModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:textCellReuseID];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:listItemCellReuseID];
    }
    [cell bindViewModel:vm];
    return cell;
}

@end
