//
//  GoodsDetailCouponChooseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCouponChooseView.h"

#import "CouponItemCell.h"

#import "GoodsDetailCouponChooseViewModel.h"
#import "CouponItemViewModel.h"

static NSString *cellReuseID = @"CouponItemCell";

@interface GoodsDetailCouponChooseView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)UIButton *bottomBtn;

@property (nonatomic,strong)GoodsDetailCouponChooseViewModel *viewModel;

@end

@implementation GoodsDetailCouponChooseView

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
    // title
    UILabel *titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                       textAlignment:NSTextAlignmentCenter
                                           textColor:@"#333333"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:@"优惠券"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(self);
    }];
    
    // 关闭按钮
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"选择样式叉"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(12.5);
    }];
    closeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [DLAlertShowAnimate disappear];
        return [RACSignal empty];
    }];
    
    // 可领取优惠券
    UILabel *tipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#333333"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"可领取优惠券"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(titleLabel.bottom).offset(16);
    }];
    
    // 底部按钮
    self.bottomBtn = [UIButton new];
    self.bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.bottomBtn setBackgroundColor:[CommUtls colorWithHexString:APP_MainColor]];
    [self.bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    self.bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [DLAlertShowAnimate disappear];
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
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(tipLabel.bottom).offset(5);
        make.bottom.mas_equalTo(self.bottomBtn.top);
    }];
    
    [mainTable registerClass:[CouponItemCell class] forCellReuseIdentifier:cellReuseID];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(GoodsDetailCouponChooseViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -tableView代理
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
    // 点击领取优惠券
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel receiveCouponAtIndexPath:indexPath];
    }];
    return cell;
}

@end
