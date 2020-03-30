//
//  ConfirmOrderViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderViewModel.h"

// 商品详情
#import "ConfirmOrderListProductCellViewModel.h"
#import "ConfirmOrderListIntegralCellViewModel.h"
#import "ConfirmOrderListCashbackCellViewModel.h"
#import "ConfirmOrderListAmountCellViewModel.h"

// 优惠券运费
#import "ConfirmOrderListCouponCellViewModel.h"
#import "ConfirmOrderListShippingCellViewModel.h"

#import "PaymentViewModel.h"
#import "ChoiceWareHouseViewModel.h"
#import "CouponUseViewModel.h"
#import "CouponItemViewModel.h"
#import "ShippingAddressSelectViewModel.h"

#import "ConfrimOrderService.h"
#import "PaymentService.h"

#import "ConfirmOrderModel.h"
// 支付结果
#import "PayResultViewModel.h"
#import "PaymentModel.h"
// 订单详情
#import "OrderDetailViewModel.h"

@interface ConfirmOrderViewModel()

@property (nonatomic,assign)ConfirmOrderViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong)ConfrimOrderService *service;
@property (nonatomic,strong)PaymentService *paymentService;

// 基本信息
@property (nonatomic,copy) NSString *goods_cart_id;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *activity_flash_id;
@property (nonatomic,copy) NSString *activity_group_id;
@property (nonatomic,copy) NSString *activity_bargain_id;
@property (nonatomic,copy) NSString *bargain_open_id;

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPhone;
@property (nonatomic,assign) BOOL userDefaulAdress;
@property (nonatomic,copy) NSString *adressContent;
@property (nonatomic,copy) NSString *user_address_id;
@property (nonatomic,copy) NSString *storehouse_id;

@property (nonatomic,assign) NSInteger productTotalCount;
@property (nonatomic,copy) NSString *productTotalPrice;

// 当前选择的优惠券
@property (nonatomic,strong)NSArray *couponItemViewModels;
// 运费
@property (nonatomic,copy) NSString *postage;

// 数据源
@property (nonatomic,strong) NSArray *dataArray;
// 商品 获取json用
@property (nonatomic,strong) NSArray *goodsArray;

@end

@implementation ConfirmOrderViewModel

#pragma mark -初始化
- (instancetype)initWithConfirm_order_from:(ConfirmOrderFrom)confirm_order_from
                                goods_type:(GoodsDetailType)goods_type
                             goods_cart_id:(NSString *)goods_cart_id
                                  goods_id:(NSString *)goods_id
                              goods_sku_id:(NSString *)goods_sku_id
                                  quantity:(NSString *)quantity
                         activity_flash_id:(NSString *)activity_flash_id
                         activity_group_id:(NSString *)activity_group_id
                       activity_bargain_id:(NSString *)activity_bargain_id
                           bargain_open_id:(NSString *)bargain_open_id
                             storehouse_id:(NSString *)storehouse_id
{
    self = [super init];
    if (self) {
        self.service = [ConfrimOrderService new];
        self.paymentService = [PaymentService new];
        
        self.confirm_order_from = confirm_order_from;
        self.goods_type = goods_type;
        self.goods_cart_id = goods_cart_id;
        self.goods_id = goods_id;
        self.goods_sku_id = goods_sku_id;
        self.quantity = quantity;
        self.activity_flash_id = activity_flash_id;
        self.activity_group_id = activity_group_id;
        self.activity_bargain_id = activity_bargain_id;
        self.bargain_open_id = bargain_open_id;
        self.storehouse_id = storehouse_id;
    }
    return self;
}

- (instancetype)initWithConfirm_order_from:(ConfirmOrderFrom)confirm_order_from
                                goods_type:(GoodsDetailType)goods_type
                             goods_cart_id:(NSString *)goods_cart_id
                                  goods_id:(NSString *)goods_id
                              goods_sku_id:(NSString *)goods_sku_id
                                  quantity:(NSString *)quantity
                         activity_flash_id:(NSString *)activity_flash_id
                         activity_group_id:(NSString *)activity_group_id
                       activity_bargain_id:(NSString *)activity_bargain_id
                           bargain_open_id:(NSString *)bargain_open_id
                             storehouse_id:(NSString *)storehouse_id
                                 reffer_id:(NSString*)reffer_id
{
    self = [super init];
    if (self) {
        self.service = [ConfrimOrderService new];
        self.paymentService = [PaymentService new];
        
        self.confirm_order_from = confirm_order_from;
        self.goods_type = goods_type;
        self.goods_cart_id = goods_cart_id;
        self.goods_id = goods_id;
        self.goods_sku_id = goods_sku_id;
        self.quantity = quantity;
        self.activity_flash_id = activity_flash_id;
        self.activity_group_id = activity_group_id;
        self.activity_bargain_id = activity_bargain_id;
        self.bargain_open_id = bargain_open_id;
        self.storehouse_id = storehouse_id;
        self.reffer_id = reffer_id;
    }
    return self;
}

#pragma mark -getData
- (void)getData
{
    RACSignal *getDataSignal = nil;
    switch (self.goods_type) {
        case GoodsDetailType_Normal:
        {
            // 储值
            getDataSignal = [self.service confirmOrderWithConfirm_order_from:[@(self.confirm_order_from) lyStringValue]
                                                               goods_cart_id:self.goods_cart_id
                                                                    goods_id:self.goods_id
                                                                goods_sku_id:self.goods_sku_id
                                                                    quantity:self.quantity] ;
        }
            break;
        case GoodsDetailType_Store:
        {
            // 积分
            getDataSignal = [self.service confirmScoreOrderWithGoods_id:self.goods_id
                                                           goods_sku_id:self.goods_sku_id
                                                               quantity:self.quantity];
        }
            break;
        case GoodsDetailType_SecKill:
        {
            // 秒杀
            getDataSignal = [self.service confirmFlashOrderWithActivity_flash_id:self.activity_flash_id
                                                                        quantity:self.quantity];
        }
            break;
        case GoodsDetailType_GroupBy:
        {
            // 拼团
            getDataSignal = [self.service confirmGroupOrderWithActivity_group_id:self.activity_group_id
                                                                        quantity:self.quantity];
        }
            break;
        case GoodsDetailType_Bargain:
        {
            // 砍价
            getDataSignal = [self.service confirmBargainOrderWithActivity_bargain_id:self.activity_bargain_id
                                                                     bargain_open_id:self.bargain_open_id];
        }
            break;

            
        default:
            break;
    }
    @weakify(self);
    RACDisposable *disPos = [getDataSignal subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithConfirmOrderModel:x];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GetDataFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithConfirmOrderModel:(ConfirmOrderModel *)model
{
    // 收货地址
    self.userName = model.user_address.receiver;
    self.userPhone = model.user_address.receiver_mobile;
    self.userDefaulAdress = [model.user_address.defaultAddress integerValue]==1?YES:NO;
    self.adressContent = model.user_address.full_address;
    self.user_address_id = [model.user_address.user_address_id lyStringValue];
    // 商品信息
    __block CGFloat totalPrice = 0;
    __block NSInteger totalAccount = 0;
    NSMutableArray *resultArray = [NSMutableArray array];
    [model.goods enumerateObjectsUsingBlock:^(ConfirmOrderGoodsDetailModel *goodsDetailModel, NSUInteger idx, BOOL * _Nonnull stop) {
    
        NSMutableArray *childVMs = [NSMutableArray array];
        // 商品
        ConfirmOrderListProductCellViewModel *productVM = [ConfirmOrderListProductCellViewModel new];
        productVM.productImgUrl = goodsDetailModel.thumb;
        productVM.productName = goodsDetailModel.title;
        productVM.productSkuString = goodsDetailModel.attr_values;
        productVM.goods_sku_id = [goodsDetailModel.goods_sku_id lyStringValue];
        if (self.goods_type == GoodsDetailType_Store) {
            productVM.productPrice = [NSString stringWithFormat:@"%@积分",goodsDetailModel.score];
        }else{
            productVM.productPrice = [NSString stringWithFormat:@"¥%@",goodsDetailModel.price];
        }
        productVM.productQuantiry = [goodsDetailModel.quantity integerValue];
        [childVMs addObject:productVM];
        // 积分
        ConfirmOrderListIntegralCellViewModel *integralVM = nil;
        if (self.goods_type!=GoodsDetailType_Store) {
            integralVM = [ConfirmOrderListIntegralCellViewModel new];
            integralVM.supportIntegral = [goodsDetailModel.use_score integerValue] > 0 ? YES:NO;
            integralVM.useScore = goodsDetailModel.use_score;
            [childVMs addObject:integralVM];
        }
        // 返现
        if (self.goods_type!=GoodsDetailType_Store && [goodsDetailModel.rebate_percent integerValue]>0) {
            ConfirmOrderListCashbackCellViewModel *cashbackVM = [ConfirmOrderListCashbackCellViewModel new];
            cashbackVM.periodPercent = goodsDetailModel.rebate_percent;
            cashbackVM.periodNumbers = [goodsDetailModel.rebate_times integerValue];
            cashbackVM.periodInterval = [goodsDetailModel.rebate_days integerValue];
            [childVMs addObject:cashbackVM];
        }
        // 总计
        ConfirmOrderListAmountCellViewModel *amountVM = [ConfirmOrderListAmountCellViewModel new];
        amountVM.productTotalNumber = [goodsDetailModel.quantity integerValue];
        // 计算数量
        totalAccount += amountVM.productTotalNumber;
        // 计算价格
        CGFloat goodsItemPrice;
        if (self.goods_type == GoodsDetailType_Store) {
            goodsItemPrice = ([goodsDetailModel.score floatValue]*amountVM.productTotalNumber);
        }else{
            goodsItemPrice = ([goodsDetailModel.price floatValue]*amountVM.productTotalNumber);
        }

        totalPrice += goodsItemPrice;
        
        if (self.goods_type == GoodsDetailType_Store) {
            amountVM.productTotalPrice = [NSString stringWithFormat:@"%ld积分",(long)goodsItemPrice];
        }else{
            amountVM.productTotalPrice = [NSString stringWithFormat:@"¥%.2f",goodsItemPrice];
            // 观察积分输入变化 刷新价格显示
            @weakify(self);
            [[RACObserve(integralVM, userInputScore) skip:1] subscribeNext:^(id x) {
                @strongify(self);
                CGFloat scoreRemovePrice = [x floatValue]*.1;
                // 刷新商品项价格
                amountVM.productTotalPrice = [NSString stringWithFormat:@"¥%.2f",(goodsItemPrice - scoreRemovePrice)];
                // 刷新总价格
                NSArray *reloadPAmountVMs = [[self.dataArray linq_selectMany:^id(LYItemUIBaseViewModel *reloadPSecItem) {
                    return reloadPSecItem.childViewModels;
                }] linq_where:^BOOL(id reloadPCellItem) {
                    return [reloadPCellItem isKindOfClass:[ConfirmOrderListAmountCellViewModel class]];
                }];
                __block CGFloat reloadPTotalPrice = 0.0;
                [reloadPAmountVMs enumerateObjectsUsingBlock:^(ConfirmOrderListAmountCellViewModel *reloadPObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    reloadPTotalPrice += [[reloadPObj.productTotalPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] floatValue];
                }];
                // 优惠券价格
                CGFloat couponValue = [self.couponItemViewModel.currentMoneyValue floatValue];
                if (couponValue>0) {
                    reloadPTotalPrice -= couponValue;
                }
                self.productTotalPrice = [NSString stringWithFormat:@"¥%.2f",reloadPTotalPrice];
                // 抛出信号刷新
                self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GetDataSuccess;
                [self.updatedContentSignal sendNext:nil];
            }];
        }
        [childVMs addObject:amountVM];
        // sec
        LYItemUIBaseViewModel *secVM = [LYItemUIBaseViewModel new];
        secVM.childViewModels = [NSArray arrayWithArray:childVMs];
        
        [resultArray addObject:secVM];
    }];
    self.goodsArray = [NSArray arrayWithArray:resultArray];
    
    // 订单总数量
    self.productTotalCount = totalAccount;
    // 订单总价格
    if (self.goods_type == GoodsDetailType_Store) {
        self.productTotalPrice = [NSString stringWithFormat:@"%ld积分",(long)totalPrice];
    }else{
        self.productTotalPrice = [NSString stringWithFormat:@"¥%.2f",totalPrice];
    }
    
    // 取货仓
    if ([self useWareHouse]) {
        ConfirmOrderListWareHouseCellViewModel *wareHouseCellVM = [ConfirmOrderListWareHouseCellViewModel new];
        self.wareHouseCellVM = wareHouseCellVM;
        LYItemUIBaseViewModel *wareHouseSecVM = [LYItemUIBaseViewModel new];
        wareHouseSecVM.childViewModels = @[wareHouseCellVM];
        
        [resultArray addObject:wareHouseSecVM];
    }

    // 优惠券、运费
    NSMutableArray *lastSecItems = [NSMutableArray array];
    if (self.goods_type!=GoodsDetailType_Store) {
        ConfirmOrderListCouponCellViewModel *couponVM = [ConfirmOrderListCouponCellViewModel new];
        couponVM.validCouponNumber = [model.coupon.coupon_total integerValue];
        self.couponItemViewModel = couponVM;
        [lastSecItems addObject:couponVM];
        if (couponVM.validCouponNumber>0) {
            // 可用优惠券列表
            NSMutableArray *resultArray = [NSMutableArray array];
            [model.coupon.coupon_list enumerateObjectsUsingBlock:^(CouponModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *startTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_start_at]
                                                    format:@"yyyy年MM月dd日"];
                NSString *endTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_end_at]
                                                  format:@"yyyy年MM月dd日"];
                NSString *validTime = [NSString stringWithFormat:@"有效期:%@至%@",startTime,endTime];
                
                GoodsDetailCouponState couponState;
                if ([obj.coupon_status integerValue] == 0) {
                    couponState = GoodsDetailCouponState_CanBeUsed;
                }else if ([obj.coupon_status integerValue] == 1){
                    couponState = GoodsDetailCouponState_Overdue;
                }else{
                    couponState = GoodsDetailCouponState_Used;
                }
                
                CouponItemViewModel *couponItemVM = [[CouponItemViewModel alloc] initWithCouponID:obj.coupon_id user_coupon_id:obj.user_coupon_id  moneyValue:obj.coupon_price tipMsg1:obj.coupon_title tipMsg2:obj.coupon_description validTime:validTime goods_cat_id:nil checkBoxStyle:YES couponState:GoodsDetailCouponState_CanBeUsed];
                [resultArray addObject:couponItemVM];
            }];
            self.couponItemViewModels = [NSArray arrayWithArray:resultArray];
        }
    }
    
    ConfirmOrderListShippingCellViewModel *shippingM = [ConfirmOrderListShippingCellViewModel new];
    shippingM.shippingMoneyValue = [model.postage lyStringValue];
    self.postage = shippingM.shippingMoneyValue;
    [lastSecItems addObject:shippingM];
    
    LYItemUIBaseViewModel *lastSecVM = [LYItemUIBaseViewModel new];
    lastSecVM.childViewModels = [NSArray arrayWithArray:lastSecItems];
    
    [resultArray addObject:lastSecVM];
    
    self.dataArray = [NSArray arrayWithArray:resultArray];
    self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GetDataSuccess;
    [self.updatedContentSignal sendNext:nil];
}
// 是否走货仓逻辑
- (BOOL)useWareHouse
{
    if (self.goods_type==GoodsDetailType_Normal || self.goods_type==GoodsDetailType_Store) {
        return YES;
    }
    return NO;
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *sectionVM = [self.dataArray objectAtIndex:section];
    return sectionVM.childViewModels.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self.dataArray objectAtIndex:indexPath.section];
    LYItemUIBaseViewModel *itemVM = [sectionVM.childViewModels objectAtIndex:indexPath.row];
    return itemVM.UIHeight;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self.dataArray objectAtIndex:indexPath.section];
    LYItemUIBaseViewModel *itemVM = [sectionVM.childViewModels objectAtIndex:indexPath.row];
    return itemVM;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self.dataArray objectAtIndex:indexPath.section];
    LYItemUIBaseViewModel *itemVM = [sectionVM.childViewModels objectAtIndex:indexPath.row];
    if ([itemVM isKindOfClass:[ConfirmOrderListWareHouseCellViewModel class]]) {
        // 取货仓
        ChoiceWareHouseViewModel *wareHouseVM = [[ChoiceWareHouseViewModel alloc] initWithWareHouseID:self.wareHouseCellVM.wareHouseID];
        self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoWareHouse;
        [self.updatedContentSignal sendNext:wareHouseVM];
    }else if ([itemVM isKindOfClass:[ConfirmOrderListCouponCellViewModel class]]) {
        ConfirmOrderListCouponCellViewModel *couponVM = (ConfirmOrderListCouponCellViewModel *)itemVM;
        if (couponVM.validCouponNumber>0) {
            // 使用优惠券
            CouponUseViewModel *couponUseVM = [[CouponUseViewModel alloc] initWithCouponItenViewModels:self.couponItemViewModels selectedCouponID:self.couponItemViewModel.currentUseCouponID];
            self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoCouponUse;
            [self.updatedContentSignal sendNext:couponUseVM];
        }
    }else if ([itemVM isKindOfClass:[ConfirmOrderListIntegralCellViewModel class]]){
        ConfirmOrderListIntegralCellViewModel *integralVM = (ConfirmOrderListIntegralCellViewModel *)itemVM;
        if (integralVM.supportIntegral) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"使用懒店积分"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField *txtName = [alert textFieldAtIndex:0];
            txtName.placeholder = @"最多支持使用N积分";
            [alert show];
        }
    }
}

#pragma mark -开始支付
- (void)gotoPaymentList
{
    if ([self useWareHouse] && self.wareHouseCellVM.wareHouseID.length == 0) {
        [DLLoading DLToolTipInWindow:@"请选择配送方式"];
        return;
    }
    // 如果不走货仓 或走货仓却选择了线上快递 需要校验收货地址
    if (![self useWareHouse] || ([self useWareHouse]&&self.wareHouseCellVM.sellerPost)) {
        if ([self.user_address_id integerValue]<=0) {
            [DLLoading DLToolTipInWindow:@"请选择收货地址"];
            return;
        }
    }
    if (self.goods_type == GoodsDetailType_Store) {
        // 积分直接支付
        @weakify(self);
        LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"你是否要支付%@购买此商品",self.productTotalPrice]
                                                         titles:@[@"我再想想",@"确认支付"]
                                                          click:^(NSInteger index) {
                                                              if (index == 1) {
                                                                  @strongify(self);
                                                                  // 支付
                                                                  [self gotoPayment];
                                                              }
                                                          }];
        [alert show];
    }else{
        // 支付
        [self gotoPayment];
    }
}
// 跳转支付
- (void)gotoPayment
{
    NSString *goods_sku_id = nil;
    if (self.goods_type == GoodsDetailType_Store) {
        // 积分商品
        goods_sku_id = self.goods_sku_id;
    }else{
        if (self.goods_type == GoodsDetailType_Normal) {
            // 储值商品
            goods_sku_id = [self fetchNormalGoodsJson];
        }
    }
    
    @weakify(self);
    switch (self.goods_type) {
        case GoodsDetailType_Normal:
        {
            // 储值 先下单 生成订单ID直接跳转待付款
            self.loading = YES;
            RACDisposable *disPos = [[self.paymentService createMoneyOrderWithGoods_sku_id:goods_sku_id user_coupon_id:self.couponItemViewModel.currentUseCouponID goods_cart_id:self.goods_cart_id postage:self.postage user_address_id:self.user_address_id storehouse_id:self.wareHouseCellVM.wareHouseID
                                      reffer_id:self.reffer_id] subscribeNext:^(PaymentModel *model) {
                @strongify(self);
                self.loading = NO;
                OrderDetailViewModel *vm = [[OrderDetailViewModel alloc] initWithOrderID:model.order_id
                                                                              orderTitle:nil];
                vm.rootPop = YES;
                self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoOrderDetail;
                [self.updatedContentSignal sendNext:vm];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = ConfirmOrderViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
        }
            break;
        case GoodsDetailType_Store:
        {
            // 积分商品直接支付 先下单 生成订单ID直接跳转待付款
            self.loading = YES;
            RACDisposable *disPos = [[self.paymentService createScoreOrderWithGoods_sku_id:goods_sku_id quantity:self.quantity user_address_id:self.user_address_id postage:self.postage storehouse_id:self.wareHouseCellVM.wareHouseID] subscribeNext:^(PaymentModel *model) {
                @strongify(self);
                self.loading = NO;
                OrderDetailViewModel *vm = [[OrderDetailViewModel alloc] initWithOrderID:model.order_id
                                                                              orderTitle:nil];
                vm.rootPop = YES;
                self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoOrderDetail;
                [self.updatedContentSignal sendNext:vm];
            } error:^(NSError *error) {
                @strongify(self);
                self.loading = NO;
                self.currentSignalType = ConfirmOrderViewModel_Signal_Type_TipLoading;
                [self.updatedContentSignal sendNext:AppErrorParsing(error)];
            }];
            [self addDisposeSignal:disPos];
            return;
        }
            break;
        case GoodsDetailType_SecKill:
        {
            // 秒杀
            PaymentViewModel *paymentVM = [[PaymentViewModel alloc] initWithActivity_flash_id:self.activity_flash_id
                                                                   quantity:self.quantity
                                                            user_address_id:self.user_address_id storehouse_id:self.storehouse_id];
            self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoPaymentList;
            [self.updatedContentSignal sendNext:paymentVM];
        }
            break;
        case GoodsDetailType_GroupBy:
        {
            // 拼团
            PaymentViewModel *paymentVM = [[PaymentViewModel alloc] initWithActivity_group_id:self.activity_group_id
                                                                   quantity:self.quantity
                                                            user_address_id:self.user_address_id storehouse_id:self.storehouse_id];
            self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoPaymentList;
            [self.updatedContentSignal sendNext:paymentVM];
        }
            break;
        case GoodsDetailType_Bargain:
        {
            // 砍价
            PaymentViewModel *paymentVM = [[PaymentViewModel alloc] initWithActivity_bargain_id:self.activity_bargain_id
                                                              bargain_open_id:self.bargain_open_id
                                                                     quantity:self.quantity
                                                              user_address_id:self.user_address_id storehouse_id:self.storehouse_id];
            self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoPaymentList;
            [self.updatedContentSignal sendNext:paymentVM];
        }
            break;
            
        default:
            break;
    }
}
// 获取商品json
- (NSString *)fetchNormalGoodsJson
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [self.goodsArray enumerateObjectsUsingBlock:^(LYItemUIBaseViewModel *sectionVM, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *goodsDict = [NSMutableDictionary dictionary];
        [sectionVM.childViewModels enumerateObjectsUsingBlock:^(LYItemUIBaseViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
            // 商品sku和数量
            if ([itemVM isKindOfClass:[ConfirmOrderListProductCellViewModel class]]) {
                ConfirmOrderListProductCellViewModel *productVM = (ConfirmOrderListProductCellViewModel *)itemVM;
                [goodsDict setObject:productVM.goods_sku_id forKey:@"goods_sku_id"];
                [goodsDict setObject:[NSString stringWithFormat:@"%ld",(long)productVM.productQuantiry] forKey:@"quantity"];
            }
            // 商品使用积分情况
            if ([itemVM isKindOfClass:[ConfirmOrderListIntegralCellViewModel class]]) {
                ConfirmOrderListIntegralCellViewModel *integralVM = (ConfirmOrderListIntegralCellViewModel *)itemVM;
                [goodsDict setObject:integralVM.userInputScore?:@"0" forKey:@"use_score"];
            }
        }];
        [resultArray addObject:goodsDict];
    }];
    return [resultArray JSONString];
}

#pragma mark -选择收货地址
- (void)selectShippingAddress
{
    ShippingAddressSelectViewModel *vm = [[ShippingAddressSelectViewModel alloc] initWithUserAddressID:self.user_address_id];
    self.currentSignalType = ConfirmOrderViewModel_Signal_Type_GotoAddressSelect;
    [self.updatedContentSignal sendNext:vm];
}

#pragma mark -刷新地址信息
- (void)resetAddressWithModel:(ShippingAddressModel *)model
{
    // 收货地址
    self.userName = model.receiver;
    self.userPhone = model.receiver_mobile;
    self.userDefaulAdress = [model.defaultAddress integerValue]==1?YES:NO;
    self.adressContent = model.full_address;
    self.user_address_id = [model.user_address_id lyStringValue];
}

#pragma mark -刷新选择优惠券之后的总价格
- (void)reloadTotalPriceWithOldCouponValue:(NSString *)oldCouponValue
                            newCouponValue:(NSString *)newCouponValue
{
    CGFloat totalPrice = [[self.productTotalPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] floatValue] + [oldCouponValue floatValue] - [newCouponValue floatValue];
    self.productTotalPrice = [NSString stringWithFormat:@"¥%.2f",totalPrice];
}

@end
