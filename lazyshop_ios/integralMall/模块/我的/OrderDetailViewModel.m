//
//  OrderDetailViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailViewModel.h"

#import "OrderDetailService.h"
#import "OrderDetailModel.h"
#import "MyOrdersService.h"

#import "OrderDetailHeaderCellViewModel.h"
#import "OrderDetailGapCellViewModel.h"
#import "OrderDetailAddressCellViewModel.h"
#import "OrderDetailStoreHouseNameCellViewModel.h"
#import "OrderDetailGoodsItemViewModel.h"
#import "OrderDetailDescCellViewModel.h"
#import "OrderDetailTotalMoneyCellViewModel.h"
#import "OrderDetailNumberCellViewModel.h"
#import "OrderDetailRefoundItemCellViewModel.h"
#import "OrderDetailDeliveryCellViewModel.h"
#import "OrderDetailGroupProgressCellViewModel.h"

#import "ProductListService.h"
#import "HomeChosenCellViewModel.h"
#import "ProductListItemViewModel.h"
#import "ProductListItemModel.h"
#import "PaymentViewModel.h"

#import "MineService.h"

@interface OrderDetailViewModel()

@property (nonatomic,strong)OrderDetailService *service;

@property (nonatomic,strong)MyOrdersService *myOrderservice;
@property (nonatomic,copy)NSString *order_id;
@property (nonatomic,strong) ProductListService *productService;
@property (nonatomic,strong) HomeChosenCellViewModel *chosenViewModel;
@property (nonatomic,assign)OrderStatus order_status;

@property (nonatomic,strong)OrderDetailModel *model;

@property (nonatomic,strong)MineService *mineService;

@end

@implementation OrderDetailViewModel

- (instancetype)initWithOrderID:(NSString *)order_id
                     orderTitle:(NSString *)orderTitle
{
    self = [super init];
    if (self) {
        self.order_id = order_id;
        self.service = [OrderDetailService new];
        self.myOrderservice = [MyOrdersService new];
        self.productService = [ProductListService new];
        self.mineService = [MineService new];
        if (orderTitle.length) {
            self.orderTitle = orderTitle;
        }else{
            self.orderTitle = @"订单详情";
        }
    }
    return self;
}

#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchOrderDetailWithOrder_id:self.order_id] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithModel:x];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];

}
// 数据处理
- (void)dealDataWithModel:(OrderDetailModel *)model
{
    self.model = model;
    
    self.order_status = [model.order_status integerValue];
    self.orderType = [model.order_type integerValue];
    self.group_left_time = [model.group_left_time integerValue];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    // 头视图
    OrderDetailHeaderCellViewModel *headerVM = [[OrderDetailHeaderCellViewModel alloc] initWithModel:model];
    [resultArray addObject:headerVM];
    // 分割1
    OrderDetailGapCellViewModel *gapVM1 = [[OrderDetailGapCellViewModel alloc] init];
    [resultArray addObject:gapVM1];
    // 收货地址
    OrderDetailAddressCellViewModel *addressVM = [[OrderDetailAddressCellViewModel alloc] initWithModel:model];
    [resultArray addObject:addressVM];
    // 分割2
    OrderDetailGapCellViewModel *gapVM2 = [[OrderDetailGapCellViewModel alloc] init];
    [resultArray addObject:gapVM2];
    // 取货仓名称
    if (model.storehouse_id>1) {
        OrderDetailStoreHouseNameCellViewModel *wareHouseVM = [[OrderDetailStoreHouseNameCellViewModel alloc] initWithModel:model];
        [resultArray addObject:wareHouseVM];
        // 分割3
        OrderDetailGapCellViewModel *gapVM3 = [[OrderDetailGapCellViewModel alloc] init];
        [resultArray addObject:gapVM3];
    }
    // 商品
    [model.order_detail enumerateObjectsUsingBlock:^(OrderDetailGoodsModel *goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderDetailGoodsItemViewModel *goodsVM = [[OrderDetailGoodsItemViewModel alloc] initWithModel:goodsModel];
        [resultArray addObject:goodsVM];
        // 申请售后
        BOOL showScoreRefound = (self.orderType==OrderType_Score&&self.order_status==OrderStatus_Complete);
        BOOL showOtherRefound = (self.orderType!=OrderType_Score&&(self.order_status==OrderStatus_NotSend||
                                                                   self.order_status==OrderStatus_ToReceive||
                                                                   self.order_status==OrderStatus_Complete||
                                                                   self.order_status==OrderStatus_GroupComplete));
        if (showScoreRefound||showOtherRefound) {
            OrderDetailRefoundItemCellViewModel *roundCellVM = [[OrderDetailRefoundItemCellViewModel alloc] initWithOrder_detail_id:goodsModel.order_detail_id];
            [resultArray addObject:roundCellVM];
            OrderDetailGapCellViewModel *roundGapVM = [[OrderDetailGapCellViewModel alloc] init];
            [resultArray addObject:roundGapVM];
        }
    }];
    // 拼单进度
    if (self.order_status==OrderStatus_ToBecameGroup) {
        if (model.group_url.length) {
            OrderDetailGroupProgressCellViewModel *groupProgressVM = [[OrderDetailGroupProgressCellViewModel alloc] initWithModel:model];
            [resultArray addObject:groupProgressVM];
        }
    }
    // 描述
    OrderDetailDescCellViewModel *descVM = [[OrderDetailDescCellViewModel alloc] initWithModel:model];
    [resultArray addObject:descVM];
    // 需付款
    OrderDetailTotalMoneyCellViewModel *payMoneyVM = [[OrderDetailTotalMoneyCellViewModel alloc] initWithModel:model];
    [resultArray addObject:payMoneyVM];
    // 分割4
    OrderDetailGapCellViewModel *gapVM4 = [[OrderDetailGapCellViewModel alloc] init];
    [resultArray addObject:gapVM4];
    // 订单号
    OrderDetailNumberCellViewModel *numVM = [[OrderDetailNumberCellViewModel alloc] initWithModel:model];
    [resultArray addObject:numVM];
    // 运单
    if (model.delivery_no.length>0) {
        // 分割5
        OrderDetailGapCellViewModel *gapVM5 = [[OrderDetailGapCellViewModel alloc] init];
        [resultArray addObject:gapVM5];
        // 运单号
        OrderDetailDeliveryCellViewModel *deliveryVM = [[OrderDetailDeliveryCellViewModel alloc] initWithModel:model];
        [resultArray addObject:deliveryVM];
    }

    self.dataArray = [NSArray arrayWithArray:resultArray];
    [self.fetchListSuccessSignal sendNext:nil];
    
    [self getRecommentd:YES];
}

// 获取为你推荐
- (void)getRecommentd:(BOOL)refresh
{
    if (refresh) {
        self.oldDataCount = 0;
    }
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:[self.chosenViewModel itemCountAtSection:0]];
    }
    // 获取商品列表
    @weakify(self);
    RACDisposable *productListDisPos = [[self.productService getRecommendProductListWithPage:page
                                                                                        type:@"0"] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(ProductListItemModel *productListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductListItemViewModel *itemVM = [[ProductListItemViewModel alloc] initWithModel:productListModel];
            [resultArray addObject:itemVM];
        }];
        if (refresh) {
            self.chosenViewModel = [[HomeChosenCellViewModel alloc] initWithItemModels:resultArray];
            self.chosenViewModel.usedForRecommend = YES;
        }else{
            self.chosenViewModel.itemModels = [self.chosenViewModel.itemModels arrayByAddingObjectsFromArray:resultArray];
        }
        if (refresh) {
            self.dataArray = [self.dataArray arrayByAddingObject:self.chosenViewModel];
        }else{
            [self.chosenViewModel resetCellHeight];
        }
        self.currentSignalType = OrderDetailViewModel_Signal_Type_GetRecommentSuccess;
        [self.updatedContentSignal sendNext:self.chosenViewModel.itemModels];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = OrderDetailViewModel_Signal_Type_GetRecommentFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:productListDisPos];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

#pragma mark -跳转
// 商品详情
- (void)gotoGoodsDetailWithVM:(id)vm
{
    self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:vm];
}
// 订单追踪
- (void)gotoDeliveryTrackWithVM:(id)vm
{
    self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoDeliveryTrack;
    [self.updatedContentSignal sendNext:vm];
}

#pragma mark -拼团邀请好友
- (void)inviteFriends
{
    @weakify(self);
    self.loading = YES;
    OrderDetailGoodsModel *goodsModel = self.model.order_detail.linq_firstOrNil;
    RACDisposable *disPos = [[self.mineService fetchGroupShareInfo] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.loading = NO;
        // 分享
        NSString *shareTitle = [dict[@"title"] stringByReplacingOccurrencesOfString:@"{goods_title}" withString:goodsModel.goods_title];
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙拼团"
                                          title:shareTitle
                                    detailTitle:dict[@"description"]
                                          image:[NSURL URLWithString:goodsModel.goods_thumb]
                                     htmlString:self.model.group_url];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        // 分享
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙拼团"
                                          title:[NSString stringWithFormat:@"快来和我拼团购买%@，你想不到的低价！",goodsModel.goods_title]
                                    detailTitle:@"还在等什么，拼多欢乐多！"
                                          image:[NSURL URLWithString:goodsModel.goods_thumb]
                                     htmlString:self.model.group_url];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -申请售后
- (void)applyAfterSaleServiceWithOrder_detail_id:(NSString *)order_detail_id
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service applyBackWithOrder_detail_id:order_detail_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self takeServicePhoneWith:x];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self takeServicePhoneWith:nil];
    }];
    [self addDisposeSignal:disPos];
}
// alert拨打电话
- (void)takeServicePhoneWith:(NSString *)service_phone
{
    if (!service_phone.length) {
        service_phone = ServicePhone;
    }
    NSString *tip = [NSString stringWithFormat:@"请联系客服 %@ 进行售后相关操作",service_phone];
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:tip
                                                     titles:@[@"取消",@"拨打"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              NSString *text = [[NSString alloc] initWithFormat:@"telprompt://%@", service_phone];
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
                                                          }
                                                      }];
    [alert show];
}

#pragma mark -订单特有 退款/维修不会走到这些逻辑
- (void)deleteOrder
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.myOrderservice deleteOrderWithOrder_id:self.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoPop;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
    
}

- (void)confirmOrder
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.myOrderservice confirmOrderWithOrder_id:self.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoPop;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

- (void)cancelOrder
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.myOrderservice cancelOrderWithOrder_id:self.order_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoPop;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

- (void)payOrder
{
    GoodsDetailType detailType;
    switch (self.orderType) {
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
                                                 order_id:self.order_id
                                              order_money:self.model.pay_total_price];
    self.currentSignalType = OrderDetailViewModel_Signal_Type_GotoPayment;
    [self.updatedContentSignal sendNext:paymentVM];
}

@end
