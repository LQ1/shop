//
//  MineView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineView.h"

#import "MineHeaderView.h"
#import "MineViewModel.h"

#import "MineOrderCell.h"
#import "MineGroupBuyingCell.h"
#import "MineBargainCell.h"
#import "MineAddressCell.h"
#import "MineSettingCell.h"
#import "MineConnectCell.h"
#import "MineBuyTipCell.h"
#import "MinePostTipCell.h"
#import "MineAfterBuyTipCell.h"
#import "JoinUsCell.h"

static NSString *MineOrderCellID = @"MineOrderCell";
static NSString *MineGroupBuyingCellID = @"MineGroupBuyingCell";
static NSString *MineBargainCellID = @"MineBargainCell";
static NSString *MineAddressCellID = @"MineAddressCell";
static NSString *MineSettingCellID = @"MineSettingCell";
static NSString *MineConnectCellID = @"MineConnectCell";
static NSString *MineBuyTipCellID = @"MineBuyTipCell";
static NSString *MinePostTipCellID = @"MinePostTipCell";
static NSString *MineAfterBuyTipCellID = @"MineAfterBuyTipCell";

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)MineViewModel *viewModel;
@property (nonatomic,strong)MineHeaderView *header;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation MineView

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
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 头视图
    MineHeaderView *header = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, MineHeaderViewHeight)];
    self.header = header;
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
    self.mainTable.tableHeaderView = self.header;
    
    [mainTable registerClass:[MineOrderCell class] forCellReuseIdentifier:MineOrderCellID];
    [mainTable registerClass:[MineGroupBuyingCell class] forCellReuseIdentifier:MineGroupBuyingCellID];
    [mainTable registerClass:[MineBargainCell class] forCellReuseIdentifier:MineBargainCellID];
    [mainTable registerClass:[MineAddressCell class] forCellReuseIdentifier:MineAddressCellID];
    [mainTable registerClass:[MineSettingCell class] forCellReuseIdentifier:MineSettingCellID];
    [mainTable registerClass:[MineConnectCell class] forCellReuseIdentifier:MineConnectCellID];
    [mainTable registerClass:[MineBuyTipCell class] forCellReuseIdentifier:MineBuyTipCellID];
    [mainTable registerClass:[MinePostTipCell class] forCellReuseIdentifier:MinePostTipCellID];
    [mainTable registerClass:[MineAfterBuyTipCell class] forCellReuseIdentifier:MineAfterBuyTipCellID];
    [mainTable registerClass:[JoinUsCell class] forCellReuseIdentifier:NSStringFromClass([JoinUsCell class])];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(MineViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.header reloadDataWithViewModel:viewModel];
    [self.mainTable reloadData];
}

#pragma mark -tableView delegate
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
    header.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.viewModel cellTypeForRowAtIndexPath:indexPath] == MineViewCellType_MyOrders) {
        return MineOrderCellHeight;
    }else if([self.viewModel cellTypeForRowAtIndexPath:indexPath] == MineViewCellType_Partner){
        return [self.viewModel getPartnerHeight]; //136;
    }
    return MineBaseRowCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *resultCell = nil;
    
    @weakify(self);
    switch ([self.viewModel cellTypeForRowAtIndexPath:indexPath]) {
        case MineViewCellType_MyOrders:
        {
            // 我的订单
            MineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:MineOrderCellID];
            [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
                @strongify(self);
                [self dealMyOrdersJump:[x intValue]];
            }];
            resultCell = cell;
            [cell reload];
        }
            break;
        case MineViewCellType_MyGroupBuy:
        {
            // 我的拼团
            MineGroupBuyingCell *cell = [tableView dequeueReusableCellWithIdentifier:MineGroupBuyingCellID];
            resultCell = cell;
            [cell reload];
        }
            break;
        case MineViewCellType_Partner:
        {
            //合伙人
            JoinUsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JoinUsCell class])];
            [cell reload:YES];
            resultCell = cell;
        }
            break;
        case MineViewCellType_MyBargain:
        {
            // 我的砍价
            MineBargainCell *cell = [tableView dequeueReusableCellWithIdentifier:MineBargainCellID];
            resultCell = cell;
            [cell reload];
        }
            break;
        case MineViewCellType_AddressManage:
        {
            // 地址管理
            MineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:MineAddressCellID];
            resultCell = cell;
        }
            break;
        case MineViewCellType_Setting:
        {
            // 设置
            MineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:MineSettingCellID];
            resultCell = cell;
        }
            break;
        case MineViewCellType_Connect:
        {
            // 联系我们
            MineConnectCell *cell = [tableView dequeueReusableCellWithIdentifier:MineConnectCellID];
            resultCell = cell;
        }
            break;
        case MineViewCellType_BuyTip:
        {
            // 购物须知
            MineBuyTipCell *cell = [tableView dequeueReusableCellWithIdentifier:MineBuyTipCellID];
            resultCell = cell;
        }
            break;
        case MineViewCellType_PostTip:
        {
            // 配送须知
            MinePostTipCell *cell = [tableView dequeueReusableCellWithIdentifier:MinePostTipCellID];
            resultCell = cell;
        }
            break;
        case MineViewCellType_AfterBuyTip:
        {
            // 售后须知
            MineAfterBuyTipCell *cell = [tableView dequeueReusableCellWithIdentifier:MineAfterBuyTipCellID];
            resultCell = cell;
        }
            break;

            
        default:
            break;
    }
    
    return resultCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

#pragma mark -我的订单跳转
- (void)dealMyOrdersJump:(int)x
{
    switch (x) {
        case MineOrderCellClickType_LookAll:
        {
            // 跳转我的订单
            [self.viewModel gotoMyOrdersWithStatus:OrderStatus_All];
        }
            break;
        case MineOrderCellClickType_WaitToPay:
        {
            // 跳转待支付
            [self.viewModel gotoMyOrdersWithStatus:OrderStatus_ToPay];
        }
            break;
        case MineOrderCellClickType_WaitToSend:
        {
            // 跳转待收货
            [self.viewModel gotoMyOrdersWithStatus:OrderStatus_ToReceive];
        }
            break;
        case MineOrderCellClickType_WaitToRecommend:
        {
            // 跳转评价中心
            [self.viewModel gotoCommentCenter];
        }
            break;
        case MineOrderCellClickType_Refound:
        {
            // 跳转退款/维权
            [self.viewModel gotoMyOrdersWithStatus:OrderStatus_Refound];
        }
            break;
            
        default:
            break;
    }
}

@end
