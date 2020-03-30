//
//  ShippingAddressSelectView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressSelectView.h"

#import "ShippingAddressSelectViewModel.h"
#import "ShippingAddressSelectCell.h"
#import "ShippingAddressSelectCellViewModel.h"

static NSString *cellReuseID = @"ShippingAddressSelectCell";

@interface ShippingAddressSelectView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ShippingAddressSelectViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation ShippingAddressSelectView

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
    
    [mainTable registerClass:[ShippingAddressSelectCell class] forCellReuseIdentifier:cellReuseID];
}

- (void)reloadDataWithViewModel:(ShippingAddressSelectViewModel *)viewModel
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
    return ShippingAddressSelectCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel itemViewModelAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
