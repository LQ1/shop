//
//  ShoppingCartView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartView.h"

#import "LYRefreshFooter.h"
#import "LYRefreshHeader.h"

#import "ShoppingCartViewModel.h"
#import "ShoppingCartBottomView.h"

#import "LYItemUIBaseCell.h"
#import "LYItemUIBaseViewModel.h"
#import "LYSectionGrayBarView.h"
#import "ShoppingCartItemCell.h"
#import "HomeChosenCell.h"
#import "ShoppingCartEmptyCell.h"

@interface ShoppingCartView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)ShoppingCartViewModel *viewModel;
@property (nonatomic,strong)ShoppingCartBottomView *bottomView;
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,assign)BOOL usedForPush;

@end

@implementation ShoppingCartView

- (instancetype)initWithUsedForPush:(BOOL)usedForPush
{
    self = [super init];
    if (self) {
        self.usedForPush = usedForPush;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 底部栏
    ShoppingCartBottomView *bottomView = [ShoppingCartBottomView new];
    self.bottomView = bottomView;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(ShoppingCartBottomViewHeight);
        if (self.usedForPush) {
            make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
    
    // 列表
    UITableView *mainTable = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStyleGrouped];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.top);
    }];
    // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
    [self.mainTable closeSelfClassSizing];

    @weakify(self);
    // 下拉刷新
    LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel getData];
    }];
    self.mainTable.mj_header = header;
    // 上拉加载
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel getRecommentd:NO];
    }];
    self.mainTable.mj_footer = footer;
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ShoppingCartViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 刷新整体布局
    if (self.viewModel.empty) {
        self.bottomView.hidden = YES;
        [self.mainTable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }else{
        self.bottomView.hidden = NO;
        [self.mainTable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomView.top);
        }];
    }
    // 刷新列表
    [self.mainTable reloadData];
    [self.mainTable.mj_header endRefreshing];
    // 刷新底部栏展示
    [self.bottomView reloadDataWithViewModel:viewModel];
}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *secVM = [self.viewModel sectionViewModelInSection:section];
    return secVM.UIHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *secVM = [self.viewModel sectionViewModelInSection:section];
    LYSectionGrayBarView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:secVM.UIReuseID];
    if (!header) {
        header = [[LYSectionGrayBarView alloc] initWithReuseIdentifier:secVM.UIReuseID];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [UIView new];
    footer.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    return footer;
}

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
    [[cell.baseClickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([cell isKindOfClass:[HomeChosenCell class]]) {
            // 跳转商品详情
            [self.viewModel gotoGoodsDetailWithVM:x];
        }else if ([cell isKindOfClass:[ShoppingCartEmptyCell class]])
        {
            // 跳转首页
            [self.viewModel gotoHomePage];
        }else if ([cell isKindOfClass:[ShoppingCartItemCell class]]){
            switch ([x integerValue]) {
                case ShoppingCartItemCellClickType_CheckBox:
                {
                    // 点击复选框
                    [self.viewModel revalCheckedAtIndexPath:indexPath];
                }
                    break;
                case ShoppingCartItemCellClickType_GoodsDetail:
                {
                    // 跳转商品详情
                    [self.viewModel gotoGoodsDetailAtIndexPath:indexPath];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
    }];
    
    if ([cell isKindOfClass:[ShoppingCartItemCell class]]) {
        // 购物车cell
        ShoppingCartItemCell *cartCell = (ShoppingCartItemCell *)cell;
        [cartCell.adderView setAddRequestBlock:^(NSInteger quantity, makeQuantityChangeBlock block) {
            [DLLoading DLLoadingInWindow:nil close:nil];
            [[[ShoppingCartService sharedInstance] updateCartGoodsQuantityWithGoods_cart_id:[self.viewModel cartIDAtIndexPath:indexPath] quantity:[NSString stringWithFormat:@"%ld",(long)quantity]] subscribeNext:^(id x) {
                [DLLoading DLHideInWindow];
                if (block) {
                    block();
                }
            } error:^(NSError *error) {
                [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
            }];
        }];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel canEditRowAtIndexPath:indexPath];
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
