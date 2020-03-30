//
//  OrderDetailView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailView.h"

#import "LYItemUIBaseCell.h"
#import "LYItemUIBaseViewModel.h"

#import "OrderDetailViewModel.h"

#import "OrderDetailRefoundItemCell.h"
#import "HomeChosenCell.h"
#import "OrderDetailDeliveryCell.h"
#import "OrderDetailGroupProgressCell.h"

#import "LYRefreshFooter.h"
#import "OrderDetailBottomInviteView.h"
#import "OrderDetailBottomActionView.h"

@interface OrderDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)OrderDetailViewModel *viewModel;
@property (nonatomic,strong)OrderDetailBottomInviteView *bottomInviteView;
@property (nonatomic,strong)OrderDetailBottomActionView *bottomActionView;

@end

@implementation OrderDetailView

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
        make.edges.mas_equalTo(0);
    }];
    
    // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
    [self.mainTable closeSelfClassSizing];

    // 上拉加载
    @weakify(self);
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel getRecommentd:NO];
    }];
    self.mainTable.mj_footer = footer;
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(OrderDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
    if (viewModel.order_status == OrderStatus_ToBecameGroup) {
        [self addBottomInvite];
    }else if (viewModel.order_status==OrderStatus_ToPay||
              viewModel.order_status==OrderStatus_ToReceive||
              viewModel.order_status==OrderStatus_Cancel){
        [self addBottomOrderAction];
    }
}
// 添加底部邀请好友
- (void)addBottomInvite
{
    // 拼单详情需要显示底部邀请好友
    if (!self.bottomInviteView) {
        self.bottomInviteView = [[OrderDetailBottomInviteView alloc] initCountDownSeconds:self.viewModel.group_left_time];
        [self addSubview:self.bottomInviteView];
        [self.bottomInviteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(OrderDetailBottomInviteViewHeight);
            make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
        }];
        [self.mainTable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomInviteView.top);
        }];
        @weakify(self);
        [self.bottomInviteView.clickSignal subscribeNext:^(id x) {
            @strongify(self);
            // 邀请好友
            [self.viewModel inviteFriends];
        }];
    }
}
// 添加底部订单操作
- (void)addBottomOrderAction
{
    // 底部 删除订单等
    if (!self.bottomActionView) {
        self.bottomActionView = [OrderDetailBottomActionView new];
        [self.bottomActionView bindViewModel:self.viewModel];
        [self addSubview:self.bottomActionView];
        [self.bottomActionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(OrderDetailBottomInviteViewHeight);
            make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
        }];
        [self.mainTable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomActionView.top);
        }];
        @weakify(self);
        [self.bottomActionView.clickSignal subscribeNext:^(id x) {
            @strongify(self);
            switch ([x integerValue]) {
                case OrderDetailBottomActionType_DeleteOrder:
                {
                    // 删除
                    [self.viewModel deleteOrder];
                }
                    break;
                case OrderDetailBottomActionType_PayOrder:
                {
                    // 付款
                    [self.viewModel payOrder];
                }
                    break;
                case OrderDetailBottomActionType_CancelOrder:
                {
                    // 取消
                    [self.viewModel cancelOrder];
                }
                    break;
                case OrderDetailBottomActionType_ConfirmOrder:
                {
                    // 确认
                    [self.viewModel confirmOrder];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
}


#pragma mark -table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *vm = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return vm.UIHeight;
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
        if ([cell isKindOfClass:[OrderDetailRefoundItemCell class]]) {
            // 点击申请退款
            [self.viewModel applyAfterSaleServiceWithOrder_detail_id:x];
        }else if ([cell isKindOfClass:[HomeChosenCell class]]) {
            // 跳转商品详情
            [self.viewModel gotoGoodsDetailWithVM:x];
        }else if ([cell isKindOfClass:[OrderDetailDeliveryCell class]]){
            // 跳转订单跟踪
            [self.viewModel gotoDeliveryTrackWithVM:x];
        }else if ([cell isKindOfClass:[OrderDetailGroupProgressCell class]]){
            // 邀请拼团
            [self.viewModel inviteFriends];
        }
    }];
    
    return cell;
}

@end
