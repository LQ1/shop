//
//  CouponUseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponUseView.h"

#import "CouponUseViewModel.h"
#import "CouponItemViewModel.h"
#import "CouponItemCell.h"

#import "LYMainColorButton.h"

static NSString *cellReuseID = @"CouponItemCell";

@interface CouponUseView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)CouponUseViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation CouponUseView

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
    self.backgroundColor = [UIColor whiteColor];
    // 底部栏
    LYMainColorButton *bottomBtn = [[LYMainColorButton alloc] initWithTitle:@"确认"
                                                             buttonFontSize:LARGE_FONT_SIZE
                                                               cornerRadius:0];
    [self addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    @weakify(self);
    bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self useCoupon];
        return [RACSignal empty];
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
        make.bottom.mas_equalTo(bottomBtn.top);
    }];
    
    [mainTable registerClass:[CouponItemCell class] forCellReuseIdentifier:cellReuseID];
}

- (void)useCoupon
{
    [self.viewModel useSelectCoupon];
}

- (void)reloadDataWithViewModel:(CouponUseViewModel *)viewModel
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
    CouponItemViewModel *itemVM = [self.viewModel itemViewModelAtIndexPath:indexPath];
    return itemVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel itemViewModelAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
