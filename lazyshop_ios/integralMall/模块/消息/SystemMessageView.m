//
//  SystemMessageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SystemMessageView.h"

#import "SystemMessageViewModel.h"
#import "MessageDateSectionView.h"
#import "MessageItemTextCell.h"
#import "LYItemUIBaseViewModel.h"

static NSString *secReuseID = @"MessageDateSectionView";
static NSString *cellReuseID = @"MessageItemTextCell";

@interface SystemMessageView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)SystemMessageViewModel *viewModel;

@end

@implementation SystemMessageView

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
    [mainTable registerClass:[MessageDateSectionView class] forHeaderFooterViewReuseIdentifier:secReuseID];
    [mainTable registerClass:[MessageItemTextCell class] forCellReuseIdentifier:cellReuseID];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(SystemMessageViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MessageDateSectionViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MessageDateSectionView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:secReuseID];
    LYItemUIBaseViewModel *headerVM = [self.viewModel sectionVMInSection:section];
    [header bindViewModel:headerVM];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *headerVM = [self.viewModel sectionVMInSection:section];
    return headerVM.childViewModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellVMForRowAtIndexPath:indexPath];
    return cellVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageItemTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellVMForRowAtIndexPath:indexPath];
    [cell bindViewModel:cellVM];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel deleteRowAtIndexPath:indexPath];
    }
}

@end
