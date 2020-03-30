//
//  HomeView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeView.h"

#import "HomeViewModel.h"
#import "LYItemUIBaseViewModel.h"
#import "LYItemUIBaseCell.h"

// 积分商品
#import "HomeScoreCell.h"
// 活动商品
#import "HomeAllActivityCell.h"
#import "HomeAllActivityDetailView.h"
// 网校精选
#import "HomeChosenCell.h"
// 精选
#import "HomeSelectedCell.h"

#import "LYRefreshHeader.h"
#import "LYRefreshFooter.h"

#import "JoinUsCell.h"


@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)HomeViewModel *viewModel;

@end

@implementation HomeView

#pragma mark -初始化
- (instancetype)initWithViewModel:(HomeViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        @weakify(self);
        // 下拉刷新
        LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel getData];
        }];
        self.mainTable.mj_header = header;
        //// 上拉加载
        //LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
            //@strongify(self);
            //[self.viewModel getGoodsListRefresh:NO];
        //}];
        //self.mainTable.mj_footer = footer;
        // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
        [self.mainTable closeSelfClassSizing];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
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
}

#pragma mark -tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return cellVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    LYItemUIBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellVM.UIReuseID];
    if (!cell) {
        cell = [[NSClassFromString(cellVM.UIClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellVM.UIReuseID];
    }
    [cell bindViewModel:cellVM];
    
    @weakify(self);
    // 首页活动
    if ([cell isKindOfClass:[HomeAllActivityCell class]]) {
        HomeAllActivityCell *allActivityCell = (HomeAllActivityCell *)cell;
        // 刷新首页列表
        [[allActivityCell.reloadHomeListSignal takeUntil:allActivityCell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.mainTable reloadData];
        }];
        // 点击活动的查看更多
        [[allActivityCell.gotoMoreListSignal takeUntil:allActivityCell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            switch ([x integerValue]) {
                case HomeAllActivityGoMoreType_SecKillList:
                {
                    [self.viewModel gotoSecKillList];
                }
                    break;
                case HomeAllActivityGoMoreType_GroupBuyList:
                {
                    [self.viewModel gotoGroupBuyList];
                }
                    break;
                case HomeAllActivityGoMoreType_BargainList:
                {
                    [self.viewModel gotoBargainList];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    
    if ([cell isKindOfClass:[HomeChosenCell class]] ||[cell isKindOfClass:[HomeAllActivityCell class]]) {
        // 跳转商品详情
        [[cell.baseClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel gotoGoodsDetailWithVM:x];
        }];
    }
    
    //合伙人点击
//    if ([cell isKindOfClass:[JoinUsCell class]]) {
//        JoinUsCell *joinUsCell = (JoinUsCell*)cell;
//        [[joinUsCell.itemClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
//            @strongify(self);
//
//        }];
//    }
    
    // 积分商品点击事件
    if ([cell isKindOfClass:[HomeScoreCell class]]) {
        HomeScoreCell *scoreCell = (HomeScoreCell *)cell;
        [[scoreCell.itemClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            // 跳转商品列表
            @strongify(self);
            [self.viewModel gotoProductListWithVM:x];
        }];
        [[scoreCell.baseClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            // 跳转积分商城
            @strongify(self);
            [self.viewModel gotoScoreGoods];
        }];
    }
    
    // 懒店精选点击事件
    if ([cell isKindOfClass:[HomeSelectedCell class]]) {
        // 跳转商品详情
        [[cell.itemClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel gotoGoodsDetailWithVM:x];
        }];
    }

    return cell;
}

@end
