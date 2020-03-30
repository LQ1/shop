//
//  MyOrdersView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersView.h"

#import "LYHeaderSwitchView.h"
#import "MyOrdersViewModel.h"
#import "LYItemUIBaseViewModel.h"
#import "LYItemUISectionBaseView.h"
#import "LYItemUIBaseCell.h"
#import "MyOrdersSectionFooter.h"

@interface MyOrdersView()

@property (nonatomic,strong)MyOrdersViewModel *viewModel;

@end

@implementation MyOrdersView

- (instancetype)initWithViewModel:(MyOrdersViewModel *)viewModel;
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        [self bindSingal];
    }
    return self;
}

- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 头视图
    @weakify(self);
    CGFloat headerHeight = 40.0f;
    LYHeaderSwitchView *headerView = [[LYHeaderSwitchView alloc] initWithHeight:headerHeight];
    headerView.divideStyle = YES;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(headerHeight);
    }];
    // 信号绑定
    [headerView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeToListWithType:[x intValue]];
    }];
    // 数据刷新
    [headerView reloadDataWithItemViewModels:[self.viewModel fetchOrderTypeViewModels]];
    
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
        make.top.mas_equalTo(headerView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    // 下拉刷新
    [self setCurrentRefreshType:AT_ALL_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = PageGetDataNumber;
    [self getRefreshTableData:^{
        @strongify(self);
        [self getData:YES];
    }];
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self getData:NO];
    }];
}
// 获取数据
- (void)getData:(BOOL)refresh
{
    [self.viewModel getData:refresh];
}

- (void)bindSingal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyOrdersViewModel_Signal_Type_FetchListSuccess:
            {
                // 获取收据成功
                if (self.viewModel.dataArray.count) {
                    self.mainTable.hidden = NO;
                    self.autoDataArray = self.viewModel.dataArray;
                    [self DLLoadingHideInSelf];
                }else{
                    [self DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData];
                    } code:DLDataEmpty title:@"暂无此类订单" buttonTitle:LOAD_FAILED_RETRY];
                }
            }
                break;
            case MyOrdersViewModel_Signal_Type_FetchListFailed:
            {
                // 获取数据失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.currentRefreshState == AT_NO_REFRESH_STATE) {
                    [self DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData];
                    } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
                }else{
                    [self recoverShowState];
                    [DLLoading DLToolTipInWindow:title];
                }
            }
                break;
            case MyOrdersViewModel_Signal_Type_ReGetData:
            {
                // 重新获取数据
                [self getData];
            }
                break;
            case MyOrdersViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *sectionVM = [self.viewModel sectionVMInSection:section];
    return sectionVM.UIHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *sectionVM = [self.viewModel sectionVMInSection:section];
    LYItemUISectionBaseView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionVM.UIReuseID];
    if (!footer) {
        footer = [[NSClassFromString(sectionVM.UIClassName) alloc] initWithReuseIdentifier:sectionVM.UIReuseID];
    }
    [footer bindViewModel:sectionVM];
    @weakify(self);
    // 点击事件
    if ([footer isKindOfClass:[MyOrdersSectionFooter class]]) {
        MyOrdersSectionFooter *orderSecFooter = (MyOrdersSectionFooter *)footer;
        [[orderSecFooter.clickSignal takeUntil:orderSecFooter.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            @strongify(self);
            switch ([x integerValue]) {
                case MyOrdersSectionFooter_ClickType_DeleteOrder:
                {
                    // 删除订单
                    [self.viewModel deleteOrderInSection:section];
                }
                    break;
                case MyOrdersSectionFooter_ClickType_ConfirmOrder:
                {
                    // 确认收货
                    [self.viewModel confirmOrderInSection:section];
                }
                    break;
                case MyOrdersSectionFooter_ClickType_CancelOrder:
                {
                    // 取消订单
                    [self.viewModel cancelOrderInSection:section];
                }
                    break;
                case MyOrdersSectionFooter_ClickType_PayOrder:
                {
                    // 付款
                    [self.viewModel payOrderInSection:section];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *sectionVM = [self.viewModel sectionVMInSection:section];
    return sectionVM.childViewModels.count;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

#pragma mark -切换显示
- (void)changeToListWithType:(OrderStatus)orderStatus
{
    [self.viewModel changeToListWithType:orderStatus];
    [self getData];
}

#pragma mark -获取数据
- (void)getData
{
    self.mainTable.hidden = YES;
    [self DLLoadingInSelf];
    [self.viewModel getData:YES];
}

@end
