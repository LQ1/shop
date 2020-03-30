//
//  GoodsDetailView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailView.h"

// 左
#import "GoodsDetailHeaderView.h"
#import "GoodsDetailBottomView.h"
#import "LYItemUISectionBaseView.h"
#import "LYItemUIBaseCell.h"
#import "GoodsDetailCouponUseCell.h"
#import "GoodsDetailPramsChooseCell.h"
#import "GoodsDetailCommentSectionView.h"
#import "GoodsDetailPostageCell.h"
// 中
#import "GoodsDetailIntroduceView.h"
// 右
#import "CommentListView.h"

#import "GoodsDetailViewModel.h"
#import "LYItemUIBaseViewModel.h"

@interface GoodsDetailView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)GoodsDetailViewModel *viewModel;

@property (nonatomic,strong)UIScrollView *mainScrollView;

@property (nonatomic,strong)GoodsDetailHeaderView *headerView;
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)GoodsDetailBottomView *bottomView;

@property (nonatomic,strong)GoodsDetailIntroduceView *middleDetailView;
@property (nonatomic,strong)CommentListView *commentView;

@end

@implementation GoodsDetailView

- (instancetype)initWithViewModel:(GoodsDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 底部按钮
    self.bottomView = [[GoodsDetailBottomView alloc] initWithViewModel:self.viewModel];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(GoodsDetailBottomViewHeight);
        make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
    }];
    
    // 滑动
    self.mainScrollView = [UIScrollView new];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.delegate = self;
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.top);
    }];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.mainScrollView);
        make.left.top.bottom.mas_equalTo(0);
    }];
    // 列表头视图
    self.headerView = [GoodsDetailHeaderView new];
    
    // 中
    self.middleDetailView = [GoodsDetailIntroduceView new];
    [self.mainScrollView addSubview:self.middleDetailView];
    [self.middleDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.mainScrollView);
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.mainTable.right);
    }];
    
    // 右
    self.commentView = [CommentListView new];
    [self.mainScrollView addSubview:self.commentView];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.mainScrollView);
        make.top.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(self.middleDetailView.right);
    }];
}

#pragma mark -scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScrollView) {
        NSInteger index = self.mainScrollView.contentOffset.x/KScreenWidth;
        [self loadViewAtIndex:index];
        [self.viewModel changeNavViewToIndex:index];
    }
}

#pragma mark -切换视图
- (void)changeViewAtIndex:(NSInteger)index
{
    self.mainScrollView.contentOffset = CGPointMake(KScreenWidth*index, 0);
    [self loadViewAtIndex:index];
}
- (void)loadViewAtIndex:(NSInteger)index
{
    if (index == 1) {
        // 获取中间详情数据
        [self.middleDetailView bindViewModel:[self.viewModel fetchIntrodecuVM]];
    }
    if (index == 2) {
        // 获取评价数据
        [self.commentView bindViewModel:[self.viewModel fetchCommentListVM]];
    }
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(GoodsDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 头视图
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, [GoodsDetailHeaderView fetchHeightWithViewModel:viewModel]);
    [self.headerView reloadDataWithViewModel:viewModel];
    self.mainTable.tableHeaderView = self.headerView;
    // table
    [self.mainTable reloadData];
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
    LYItemUIBaseViewModel *UIVM = [self.viewModel baseUIVMInSection:section];
    if (!UIVM.UIClassName.length) {
        return nil;
    }
    LYItemUISectionBaseView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:UIVM.UIReuseID];
    if (!header) {
        header = [[NSClassFromString(UIVM.UIClassName) alloc] initWithReuseIdentifier:UIVM.UIReuseID];
    }
    [header bindViewModel:UIVM];
    // 点击全部评价
    @weakify(self);
    if ([header isKindOfClass:[GoodsDetailCommentSectionView class]]) {
        [[((GoodsDetailCommentSectionView*)header).clickSignal takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel changeNavViewToIndex:2];
        }];
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *vm = [self.viewModel baseUIVMAtIndexPath:indexPath];
    return vm.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *vm = [self.viewModel baseUIVMAtIndexPath:indexPath];
    LYItemUIBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:vm.UIReuseID];
    if (!cell) {
        cell = [[NSClassFromString(vm.UIClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vm.UIReuseID];
    }
    [cell bindViewModel:vm];
    // 优惠券右侧点击
    @weakify(self);
    if ([cell isKindOfClass:[GoodsDetailCouponUseCell class]]) {
        [[((GoodsDetailCouponUseCell *)cell).moreBtnClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel gotoCouponChoose];
        }];
    }
    // 商品参数右侧点击
    if ([cell isKindOfClass:[GoodsDetailPramsChooseCell class]]) {
        [[((GoodsDetailPramsChooseCell *)cell).moreBtnClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self)
            [self.viewModel gotoPattrnChooseWithConfirmStyle:NO
                                               confirmAction:0];
        }];
    }
    // 商品标签点击
    if ([cell isKindOfClass:[GoodsDetailPostageCell class]]) {
        [[((GoodsDetailPostageCell *)cell).clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel gotoGoodsTagsDetailAtIndexPath:indexPath];
        }];
    }
    return cell;

}

@end
