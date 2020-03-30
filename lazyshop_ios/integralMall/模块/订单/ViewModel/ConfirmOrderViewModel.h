//
//  ConfirmOrderViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

#import "ConfirmOrderListWareHouseCellViewModel.h"
#import "ConfirmOrderListCouponCellViewModel.h"

@class ShippingAddressModel;

typedef NS_ENUM(NSInteger, ConfirmOrderViewModel_Signal_Type)
{
    ConfirmOrderViewModel_Signal_Type_TipLoading = 0,
    ConfirmOrderViewModel_Signal_Type_GetDataSuccess,
    ConfirmOrderViewModel_Signal_Type_GetDataFailed,
    ConfirmOrderViewModel_Signal_Type_GotoWareHouse,
    ConfirmOrderViewModel_Signal_Type_GotoCouponUse,
    ConfirmOrderViewModel_Signal_Type_GotoPaymentList,
    ConfirmOrderViewModel_Signal_Type_GotoAddressSelect,
    ConfirmOrderViewModel_Signal_Type_GotoPayResult,
    ConfirmOrderViewModel_Signal_Type_GotoOrderDetail
};

typedef NS_ENUM(NSInteger, ConfirmOrderFrom)
{
    ConfirmOrderFrom_ShoppingCart = 0,
    ConfirmOrderFrom_GoodsDetail
};

@interface ConfirmOrderViewModel : BaseViewModel

@property (nonatomic,readonly)ConfirmOrderViewModel_Signal_Type currentSignalType;

@property (nonatomic,assign)ConfirmOrderFrom confirm_order_from;
@property (nonatomic,assign)GoodsDetailType goods_type;

@property (nonatomic,readonly) NSString *userName;
@property (nonatomic,readonly) NSString *userPhone;
@property (nonatomic,readonly) BOOL userDefaulAdress;
@property (nonatomic,readonly) NSString *adressContent;
@property (nonatomic,readonly) NSString *user_address_id;

@property (nonatomic,readonly) NSInteger productTotalCount;
@property (nonatomic,readonly) NSString *productTotalPrice;

@property (nonatomic,copy) NSString *reffer_id;

@property (nonatomic,strong) ConfirmOrderListWareHouseCellViewModel *wareHouseCellVM;
@property (nonatomic,strong) ConfirmOrderListCouponCellViewModel *couponItemViewModel;

/*
 *  初始化
 */
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
                             storehouse_id:(NSString *)storehouse_id;
//with reffer id
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
                                 reffer_id:(NSString*)reffer_id;

- (void)getData;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)gotoPaymentList;

- (void)selectShippingAddress;
- (void)resetAddressWithModel:(ShippingAddressModel *)model;

/*
 *  选中优惠券后刷新总价格
 */
- (void)reloadTotalPriceWithOldCouponValue:(NSString *)oldCouponValue
                            newCouponValue:(NSString *)newCouponValue;

@end
