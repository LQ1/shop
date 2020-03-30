//
//  PaymentViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentViewModel.h"

#import "PaymentItemCellViewModel.h"
#import "PaymentService.h"
#import "PaymentModel.h"
#import "PayResultViewModel.h"

#import "DLOtherPayController.h"

#import "WXPayModel.h"

#import "OrderDetailViewModel.h"

@interface PaymentViewModel()

@property (nonatomic,strong)PaymentService *service;
@property (nonatomic,assign)PaymentViewModel_Signal_Type currentSignalType;

@property (nonatomic,assign)GoodsDetailType detailType;
@property (nonatomic,copy)NSString *goods_sku_id;
@property (nonatomic,copy)NSString *user_coupon_id;
@property (nonatomic,copy)NSString *goods_cart_id;

@property (nonatomic,copy)NSString *postage;

@property (nonatomic,copy)NSString *quantity;
@property (nonatomic,copy)NSString *user_address_id;
@property (nonatomic,copy)NSString *storehouse_id;

// 活动相关
@property (nonatomic,copy)NSString *activity_group_id;
@property (nonatomic,copy)NSString *activity_flash_id;
@property (nonatomic,copy)NSString *activity_bargain_id;
@property (nonatomic,copy)NSString *bargain_open_id;

@property (nonatomic,strong)NSArray *dataArray;

// 下单结果
@property (nonatomic,copy)NSString *orderID;
@property (nonatomic,copy)NSString *orderMoney;

// 是否已下单
@property (nonatomic,assign) BOOL hasInitOrder;

@end

@implementation PaymentViewModel

#pragma mark -我的订单 继续付款
- (instancetype)initWithWithGoodsDetailType:(GoodsDetailType)detailType
                                   order_id:(NSString *)order_id
                                order_money:(NSString *)orderMoney
{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = detailType;
        
        self.orderID = order_id;
        self.orderMoney = orderMoney;

        self.hasInitOrder = YES;
    }
    return self;
}

#pragma mark -储值商品
- (instancetype)initWithWithGoods_sku_id:(NSString *)goods_sku_id
                          user_coupon_id:(NSString *)user_coupon_id
                           goods_cart_id:(NSString *)goods_cart_id
                                 postage:(NSString *)postage
                         user_address_id:(NSString *)user_address_id

{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsDetailType_Normal;
        
        self.goods_sku_id = goods_sku_id;
        self.user_coupon_id = user_coupon_id;
        self.goods_cart_id = goods_cart_id;
        self.postage = postage;
        self.user_address_id = user_address_id;
    }
    return self;
}

#pragma mark -拼团商品
- (instancetype)initWithActivity_group_id:(NSString *)activity_group_id
                                 quantity:(NSString *)quantity
                          user_address_id:(NSString *)user_address_id
                            storehouse_id:(NSString *)storehouse_id
{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsDetailType_GroupBy;

        self.activity_group_id = activity_group_id;
        self.quantity = quantity;
        self.user_address_id = user_address_id;
        self.storehouse_id = storehouse_id;
    }
    return self;
}

#pragma mark -砍价商品
- (instancetype)initWithActivity_bargain_id:(NSString *)activity_bargain_id
                            bargain_open_id:(NSString *)bargain_open_id
                                   quantity:(NSString *)quantity
                            user_address_id:(NSString *)user_address_id
                              storehouse_id:(NSString *)storehouse_id
{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsDetailType_Bargain;
        
        self.activity_bargain_id = activity_bargain_id;
        self.bargain_open_id = bargain_open_id;
        self.quantity = quantity;
        self.user_address_id = user_address_id;
        self.storehouse_id = storehouse_id;
    }
    return self;
}

#pragma mark -秒杀商品
- (instancetype)initWithActivity_flash_id:(NSString *)activity_flash_id
                                 quantity:(NSString *)quantity
                          user_address_id:(NSString *)user_address_id
                            storehouse_id:(NSString *)storehouse_id
{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsDetailType_SecKill;
        
        self.activity_flash_id = activity_flash_id;
        self.quantity = quantity;
        self.user_address_id = user_address_id;
        self.storehouse_id = storehouse_id;
    }
    return self;
}

#pragma mark -积分商品
- (instancetype)initWithWithScoreGoods_sku_id:(NSString *)goods_sku_id
                                     quantity:(NSString *)quantity
                              user_address_id:(NSString *)user_address_id
                                        score:(NSString *)score
{
    self = [super init];
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsDetailType_Store;
        
        self.goods_sku_id = goods_sku_id;
        self.quantity = quantity;
        self.user_address_id = user_address_id;
        self.orderMoney = score;
    }
    return self;
}

/*
 *  加入合伙人
 */
- (instancetype)initWithJoinPartner_pre_id:(int)nOrder_id{
    if (self) {
        self.service = [PaymentService new];
        self.detailType = GoodsPartnerType_Join;
        self.orderID = [NSString stringWithFormat:@"%d",nOrder_id];
        self.orderMoney = @"0.1";
       
    }
    return self;
}

#pragma mark -创建订单
- (void)getData
{
    if (self.hasInitOrder) {
        // 来自我的订单 无需下单
        PaymentModel *paymentModel = [PaymentModel new];
        paymentModel.order_id = self.orderID;
        paymentModel.pay_total_price = self.orderMoney;
        [self dealDataWithModel:paymentModel];
        self.currentSignalType = PaymentViewModel_Signal_Type_GetDataSuccess;
        [self.updatedContentSignal sendNext:nil];
        return;
    }
    
    // 需要先下单
    RACSignal *createOrderSignal = nil;
    switch (self.detailType) {
        case GoodsDetailType_GroupBy:
        {
            createOrderSignal = [self.service createGroupOrderWithActivity_group_id:self.activity_group_id
                                                                           quantity:self.quantity
                                                                    user_address_id:self.user_address_id
                                                                      storehouse_id:self.storehouse_id];
        }
            break;
        case GoodsDetailType_Bargain:
        {
            createOrderSignal = [self.service createBargainOrderWithActivity_bargain_id:self.activity_bargain_id
                                                                        bargain_open_id:self.bargain_open_id
                                                                               quantity:self.quantity
                                                                        user_address_id:self.user_address_id
                                                                          storehouse_id:self.storehouse_id];
        }
            break;
        case GoodsDetailType_SecKill:
        {
            createOrderSignal = [self.service createFlashOrderWithActivity_flash_id:self.activity_flash_id
                                                                           quantity:self.quantity
                                                                    user_address_id:self.user_address_id
                                                                      storehouse_id:self.storehouse_id];
        }
            break;
            
        default:
            break;
    }
    @weakify(self);
    if (self.detailType == GoodsDetailType_Store) {
        // 积分直接展示支付结果
        RACDisposable *disPos = [createOrderSignal subscribeNext:^(PaymentModel *model) {
            @strongify(self);
            self.orderID = [model.order_id lyStringValue];
            self.orderMoney = [model.pay_total_score lyStringValue];
            [self payMentCompleteWithPaymentType:PayMentType_Score
                                         success:YES];
        } error:^(NSError *error) {
            @strongify(self);
            [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
            [self payMentCompleteWithPaymentType:PayMentType_Score
                                         success:NO];
        }];
        [self addDisposeSignal:disPos];
    }else{
        // 其他跳转支付方式
        RACDisposable *disPos = [createOrderSignal subscribeNext:^(id x) {
            @strongify(self);
            [self dealDataWithModel:x];
        } error:^(NSError *error) {
            @strongify(self);
            self.currentSignalType = PaymentViewModel_Signal_Type_GetDataFailed;
            [self.updatedContentSignal sendNext:error];
        }];
        [self addDisposeSignal:disPos];
    }
}

// 数据处理
- (void)dealDataWithModel:(PaymentModel *)model
{
    self.orderID = [model.order_id lyStringValue];
    self.orderMoney = model.pay_total_price;
    // 微信支付
    PaymentItemCellViewModel *wxPaymentVM = [PaymentItemCellViewModel new];
    wxPaymentVM.paymentImageName = @"微信-支付";
    wxPaymentVM.paymentTitle = @"微信支付";
    wxPaymentVM.paymentDesc = @"微信安全支付";
    wxPaymentVM.selected = YES;
    wxPaymentVM.payMentType = PayMentType_WXPay;
    // 支付宝支付
    PaymentItemCellViewModel *aliPaymentVM = [PaymentItemCellViewModel new];
    aliPaymentVM.paymentImageName = @"支付宝";
    aliPaymentVM.paymentTitle = @"支付宝支付";
    aliPaymentVM.paymentDesc = @"支付宝安全支付";
    aliPaymentVM.payMentType = PayMentType_AliPay;
    // 银联支付
    PaymentItemCellViewModel *unionPaymentVM = [PaymentItemCellViewModel new];
    unionPaymentVM.paymentImageName = @"银联";
    unionPaymentVM.paymentTitle = @"银联支付";
    unionPaymentVM.paymentDesc = @"银联安全支付";
    unionPaymentVM.payMentType = PayMentType_UnionPay;
    // 到店支付
    PaymentItemCellViewModel *shopPaymentVM = [PaymentItemCellViewModel new];
    shopPaymentVM.paymentImageName = @"到店付款";
    shopPaymentVM.paymentTitle = @"到店支付";
    shopPaymentVM.payMentType = PayMentType_ShopPay;

    if (self.detailType != GoodsDetailType_GroupBy &&
        self.detailType != GoodsDetailType_Bargain &&
        self.detailType != GoodsDetailType_SecKill) {
        // 非活动商品 展示到店支付
        self.dataArray = @[wxPaymentVM,aliPaymentVM,unionPaymentVM,shopPaymentVM];
    }else{
        self.dataArray = @[wxPaymentVM,aliPaymentVM,unionPaymentVM];
    }

    
    self.currentSignalType = PaymentViewModel_Signal_Type_GetDataSuccess;
    [self.updatedContentSignal sendNext:nil];
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

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(PaymentItemCellViewModel *vm, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            vm.selected = YES;
        }else{
            vm.selected = NO;
        }
    }];
}

#pragma mark -startToPayWithSelectedPayment
- (void)startToPayWithSelectedPayment
{
    PaymentItemCellViewModel *selectedPaymentVM = [self.dataArray linq_where:^BOOL(PaymentItemCellViewModel *item) {
        return item.selected == YES;
    }].linq_firstOrNil;
    switch (selectedPaymentVM.payMentType) {
        case PayMentType_WXPay:
        {
            // 微信支付
            @weakify(self);
            self.loading = YES;
            RACDisposable *disPos = [[self.service fetchWXPayOrderStringWithOrderID:self.orderID] subscribeNext:^(WXPayModel *wxPayModel) {
                @strongify(self);
                self.loading = NO;
                [[DLOtherPayController sharedInstance] startWXPayWithAppid:wxPayModel.appid
                                                                 partnerID:wxPayModel.partnerid
                                                                  prepayID:wxPayModel.prepayid
                                                                  nonceStr:wxPayModel.noncestr
                                                                 timeStamp:[wxPayModel.timestamp intValue]
                                                                   package:wxPayModel.package
                                                                      sign:wxPayModel.sign
                                                                isAppAgree:[LYAppCheckManager shareInstance].isAppAgree
            paySuccess:^{
                // 微信支付成功
                @strongify(self);
                [self payMentCompleteWithPaymentType:PayMentType_WXPay
                                             success:YES];
            } payFailed:^{
                // 微信支付失败
                @strongify(self);
                [self payMentCompleteWithPaymentType:PayMentType_WXPay
                                             success:NO];
            }];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = PaymentViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
        }
            break;
        case PayMentType_AliPay:
        {
            // 支付宝支付
            @weakify(self);
            self.loading = YES;
            RACDisposable *disPos = [[self.service fetchAliPayOrderStringWithOrderID:self.orderID] subscribeNext:^(id x) {
                @strongify(self);
                self.loading = NO;
                [[DLOtherPayController sharedInstance] startAliPayWithOrderString:x paySuccess:^{
                    // 支付宝支付成功
                    @strongify(self);
                    [self payMentCompleteWithPaymentType:PayMentType_AliPay
                                                 success:YES];
                } payFailed:^{
                    // 支付宝支付失败
                    @strongify(self);
                    [self payMentCompleteWithPaymentType:PayMentType_AliPay
                                                 success:NO];
                }];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = PaymentViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
        }
            break;
        case PayMentType_UnionPay:
        {
            // 银联支付
            @weakify(self);
            self.loading = YES;
            RACDisposable *disPos = [[self.service fetchUnionPayOrderStringWithOrderID:self.orderID] subscribeNext:^(id x) {
                @strongify(self);
                self.loading = NO;
                [[DLOtherPayController sharedInstance] startUnionSDKPayWithTranNumber:x
                                                                       viewController:self.unionPayViewController
                 paySuccess:^{
                     // 银联支付成功
                     @strongify(self);
                     [self payMentCompleteWithPaymentType:PayMentType_UnionPay
                                                  success:YES];
                 } payFailed:^{
                     // 银联支付失败
                     @strongify(self);
                     [self payMentCompleteWithPaymentType:PayMentType_UnionPay
                                                  success:NO];
                 }];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = PaymentViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
        }
            break;
        case PayMentType_ShopPay:
        {
            // 到店支付
            @weakify(self);
            self.loading = YES;
            RACDisposable *disPos = [[self.service shopPayWithOrderID:self.orderID] subscribeNext:^(id x) {
                @strongify(self);
                self.loading = NO;
                // 到店支付成功
                [self payMentCompleteWithPaymentType:PayMentType_ShopPay
                                             success:YES];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = PaymentViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
        }
            break;
            
        default:
            break;
    }
}
// 支付完成
- (void)payMentCompleteWithPaymentType:(PayMentType)paymentType
                               success:(BOOL)success
{
    NSString *payValue = nil;
    if (self.detailType == GoodsDetailType_Store) {
        payValue = [NSString stringWithFormat:@"%@积分",self.orderMoney];
    }else{
        payValue = [NSString stringWithFormat:@"¥ %@",self.orderMoney];
    }
    PayResultViewModel *resultVM = [[PayResultViewModel alloc] initWithPaySuccess:success
                                                                      payMentType:paymentType
                                                                         payValue:payValue
                                                                         order_id:self.orderID];
    self.currentSignalType = PaymentViewModel_Signal_Type_GotoPayResult;
    [self.updatedContentSignal sendNext:resultVM];
}

#pragma mark -获取vm
// 获取订单详情VM
- (id)fetchRootPopOrderDetailVM
{
    OrderDetailViewModel *vm = [[OrderDetailViewModel alloc] initWithOrderID:self.orderID
                                                                  orderTitle:nil];
    vm.rootPop = YES;
    return vm;
}

@end
