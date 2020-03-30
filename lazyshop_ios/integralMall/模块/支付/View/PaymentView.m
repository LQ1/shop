//
//  PaymentView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentView.h"

#import "PaymentViewModel.h"
#import "PaymentHeaderView.h"
#import "LYMainColorButton.h"
#import "PaymentItemCell.h"

static NSString *cellReuseID = @"PaymentItemCell";

@interface PaymentView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)PaymentViewModel *viewModel;
@property (nonatomic,strong)PaymentHeaderView *headerView;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation PaymentView

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
    
    self.headerView = [[PaymentHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, PaymentHeaderViewHeight)];
    
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
    
    [mainTable registerClass:[PaymentItemCell class] forCellReuseIdentifier:cellReuseID];
    
    self.mainTable.tableHeaderView = self.headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 140)];
    LYMainColorButton *payButton = [[LYMainColorButton alloc] initWithTitle:@"确认支付"
                                                             buttonFontSize:20
                                                               cornerRadius:3];
    [footerView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
        make.centerY.mas_equalTo(footerView);
    }];
    self.mainTable.tableFooterView = footerView;
    
    @weakify(self);
    payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self startToPayWithSelectedPayment];
        return [RACSignal empty];
    }];
}

- (void)startToPayWithSelectedPayment
{
    if ([self.viewModel.orderMoney floatValue] <= 0) {
        [DLLoading DLToolTipInWindow:@"支付金额不能小于0!"];
        return;
    }
    
    [self.viewModel startToPayWithSelectedPayment];
}

- (void)realodDataWithViewModel:(PaymentViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.headerView realodDataWithViewModel:viewModel];
    [self.mainTable reloadData];
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
    [self.mainTable reloadData];
}

@end
