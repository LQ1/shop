//
//  ShippingAddressManageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressManageView.h"

#import "ShippingAddressManageViewModel.h"
#import "ShippingAddressManageCell.h"
#import "ShippingAddressManageCellViewModel.h"

static NSString *cellReuseID = @"ShippingAddressManageCell";

@interface ShippingAddressManageView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ShippingAddressManageViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation ShippingAddressManageView

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
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[ShippingAddressManageCell class] forCellReuseIdentifier:cellReuseID];
}

- (void)reloadDataWithViewModel:(ShippingAddressManageViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ShippingAddressManageCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel itemViewModelAtIndexPath:indexPath]];
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        switch ([x integerValue]) {
            case ShippingAddressManageCellClickType_SetDefault:
            {
                // 设置默认地址
                [self.viewModel setDefaultAtRowAtIndexPath:indexPath];
            }
                break;
            case ShippingAddressManageCellClickType_Edit:
            {
                // 编辑
                [self.viewModel editAtRowAtIndexPath:indexPath];
            }
                break;
            case ShippingAddressManageCellClickType_Delete:
            {
                // 删除
                [self.viewModel deleteAtRowAtIndexPath:indexPath];
            }
                break;
                
            default:
                break;
        }
    }];
    return cell;
}


@end
