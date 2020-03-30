//
//  MyOrdersViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersViewModel.h"

#import "MyOrdersService.h"
#import "LYHeaderSwitchItemViewModel.h"
#import "MyOrderListItemViewModel.h"
#import "MyOrderModel.h"
#import "MyRefoundItemModel.h"
#import "MyRefoundItemViewModel.h"

#import "OrderDetailViewModel.h"
#import "PaymentViewModel.h"

@interface MyOrdersViewModel()

@property (nonatomic, strong) MyOrdersService *service;
@property (nonatomic, assign) OrderStatus orderStatus;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MyOrdersViewModel

- (instancetype)initWithOrderStatus:(OrderStatus)orderStatus
{
    self = [super init];
    if (self) {
        self.service = [MyOrdersService new];
        self.orderStatus = orderStatus;
    }
    return self;
}

#pragma mark -获取头部显示
- (NSArray *)fetchOrderTypeViewModels
{
    LYHeaderSwitchItemViewModel *item1 = [LYHeaderSwitchItemViewModel new];
    item1.title = @"全部";
    item1.itemType = OrderStatus_All;
    
    LYHeaderSwitchItemViewModel *item2 = [LYHeaderSwitchItemViewModel new];
    item2.title = @"待支付";
    item2.itemType = OrderStatus_ToPay;
    
    LYHeaderSwitchItemViewModel *item3 = [LYHeaderSwitchItemViewModel new];
    item3.title = @"待收货";
    item3.itemType = OrderStatus_ToReceive;
    
    LYHeaderSwitchItemViewModel *item4 = [LYHeaderSwitchItemViewModel new];
    item4.title = @"退款/维权";
    item4.itemType = OrderStatus_Refound;
    
    NSArray *headers = @[item1,item2,item3,item4];
    
    // 选中状态
    [headers enumerateObjectsUsingBlock:^(LYHeaderSwitchItemViewModel *item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (item.itemType == self.orderStatus) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }];
    
    return headers;
}

#pragma mark -切换
- (void)changeToListWithType:(OrderStatus)orderStatus
{
    self.orderStatus = orderStatus;
}

#pragma mark -获取订单列表
- (void)getData:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.dataArray.count];
    }

    @weakify(self);
    if (self.orderStatus == OrderStatus_Refound) {
        // 退款/维修
        @weakify(self);
        RACDisposable *disPos = [[self.service backListWithPage:page] subscribeNext:^(id x) {
            @strongify(self);
            NSMutableArray *resultArray = [NSMutableArray array];
            [x enumerateObjectsUsingBlock:^(MyRefoundItemModel *refoundModel, NSUInteger idx, BOOL * _Nonnull stop) {
                MyRefoundItemViewModel *sectionVM = [[MyRefoundItemViewModel alloc] initWithModel:refoundModel];
                [resultArray addObject:sectionVM];
            }];
            if (refresh) {
                self.dataArray = [NSArray arrayWithArray:resultArray];
            }else{
                self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
            }
            self.currentSignalType = MyOrdersViewModel_Signal_Type_FetchListSuccess;
            [self.updatedContentSignal sendNext:nil];
        } error:^(NSError *error) {
            @strongify(self);
            self.currentSignalType = MyOrdersViewModel_Signal_Type_FetchListFailed;
            [self.updatedContentSignal sendNext:error];
        }];
        [self addDisposeSignal:disPos];

    }else{
        // 全部/待支付/待收货
        NSString *orderDataStatus = @"";
        switch (self.orderStatus) {
            case OrderStatus_All:
            {
                orderDataStatus = @"0";
            }
                break;
            case OrderStatus_ToPay:
            {
                orderDataStatus = @"1";
            }
                break;
            case OrderStatus_ToReceive:
            {
                orderDataStatus = @"2";
            }
                break;
                
            default:
                break;
        }
        RACDisposable *disPos = [[self.service fetchMyOrdersListWithOrder_status:orderDataStatus page:page] subscribeNext:^(NSArray *x) {
            @strongify(self);
            NSMutableArray *resultArray = [NSMutableArray array];
            [x enumerateObjectsUsingBlock:^(MyOrderModel *orderModel, NSUInteger idx, BOOL * _Nonnull stop) {
                MyOrderListItemViewModel *sectionVM = [[MyOrderListItemViewModel alloc] initWithModel:orderModel];
                [resultArray addObject:sectionVM];
            }];
            if (refresh) {
                self.dataArray = [NSArray arrayWithArray:resultArray];
            }else{
                self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
            }
            self.currentSignalType = MyOrdersViewModel_Signal_Type_FetchListSuccess;
            [self.updatedContentSignal sendNext:nil];
        } error:^(NSError *error) {
            @strongify(self);
            self.currentSignalType = MyOrdersViewModel_Signal_Type_FetchListFailed;
            [self.updatedContentSignal sendNext:error];
        }];
        [self addDisposeSignal:disPos];
    }
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)sectionVMInSection:(NSInteger)section
{
    return [self.dataArray objectAtIndex:section];
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self sectionVMInSection:indexPath.section];
    return [sectionVM.childViewModels objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self sectionVMInSection:indexPath.section];
    NSString *order_id = nil;
    // 订单跳订单详情 退款/维修不可点击
    if ([sectionVM isKindOfClass:[MyOrderListItemViewModel class]]) {
        order_id = ((MyOrderListItemViewModel*)sectionVM).model.order_id;
        OrderDetailViewModel *detailVM = [[OrderDetailViewModel alloc] initWithOrderID:order_id orderTitle:nil];
        self.currentSignalType = MyOrdersViewModel_Signal_Type_GotoOrderDetail;
        [self.updatedContentSignal sendNext:detailVM];
    }
}

#pragma mark -订单特有 退款/维修不会走到这些逻辑
- (void)deleteOrderInSection:(NSInteger)section
{
    @weakify(self);
    self.loading = YES;
    MyOrderListItemViewModel *sectionVM = [self sectionVMInSection:section];
    RACDisposable *disPos = [[self.service deleteOrderWithOrder_id:sectionVM.model.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_ReGetData;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];

}

- (void)confirmOrderInSection:(NSInteger)section
{
    @weakify(self);
    self.loading = YES;
    MyOrderListItemViewModel *sectionVM = [self sectionVMInSection:section];
    RACDisposable *disPos = [[self.service confirmOrderWithOrder_id:sectionVM.model.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_ReGetData;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

- (void)cancelOrderInSection:(NSInteger)section
{
    @weakify(self);
    self.loading = YES;
    MyOrderListItemViewModel *sectionVM = [self sectionVMInSection:section];
    RACDisposable *disPos = [[self.service cancelOrderWithOrder_id:sectionVM.model.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_ReGetData;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = MyOrdersViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

- (void)payOrderInSection:(NSInteger)section
{
    MyOrderListItemViewModel *sectionVM = [self sectionVMInSection:section];
    
    GoodsDetailType detailType;
    switch ([sectionVM.model.order_type integerValue]) {
        case OrderType_Normal:
        {
            detailType = GoodsDetailType_Normal;
        }
            break;
        case OrderType_SecKill:
        {
            detailType = GoodsDetailType_SecKill;
        }
            break;
        case OrderType_Group:
        {
            detailType = GoodsDetailType_GroupBy;
        }
            break;
        case OrderType_Bargain:
        {
            detailType = GoodsDetailType_Bargain;
        }
            break;
            
        default:
            detailType = GoodsDetailType_Normal;
            break;
    }
    PaymentViewModel *paymentVM =
    [[PaymentViewModel alloc] initWithWithGoodsDetailType:detailType
                                                 order_id:sectionVM.model.order_id
                                              order_money:sectionVM.model.pay_total_price];
    self.currentSignalType = MyOrdersViewModel_Signal_Type_GotoPayment;
    [self.updatedContentSignal sendNext:paymentVM];
}

@end
