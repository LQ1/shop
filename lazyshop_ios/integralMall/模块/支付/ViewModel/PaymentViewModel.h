//
//  PaymentViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger, PaymentViewModel_Signal_Type)
{
    PaymentViewModel_Signal_Type_TipLoading = 0,
    PaymentViewModel_Signal_Type_GetDataSuccess,
    PaymentViewModel_Signal_Type_GetDataFailed,
    PaymentViewModel_Signal_Type_GotoPayResult
};

@interface PaymentViewModel : BaseViewModel

@property (nonatomic,readonly)PaymentViewModel_Signal_Type currentSignalType;

@property (nonatomic,readonly) NSString *orderMoney;

@property (nonatomic,weak) UIViewController *unionPayViewController;

/*
 *  我的订单 继续付款
 */
- (instancetype)initWithWithGoodsDetailType:(GoodsDetailType)detailType
                                   order_id:(NSString *)order_id
                                order_money:(NSString *)orderMoney;


/*
 *  储值商品
 */
- (instancetype)initWithWithGoods_sku_id:(NSString *)goods_sku_id
                          user_coupon_id:(NSString *)user_coupon_id
                           goods_cart_id:(NSString *)goods_cart_id
                                 postage:(NSString *)postage
                         user_address_id:(NSString *)user_address_id;
/*
 *  拼团
 */
- (instancetype)initWithActivity_group_id:(NSString *)activity_group_id
                                 quantity:(NSString *)quantity
                          user_address_id:(NSString *)user_address_id
                            storehouse_id:(NSString *)storehouse_id;

/*
 *  砍价商品
 */
- (instancetype)initWithActivity_bargain_id:(NSString *)activity_bargain_id
                            bargain_open_id:(NSString *)bargain_open_id
                                   quantity:(NSString *)quantity
                            user_address_id:(NSString *)user_address_id
                              storehouse_id:(NSString *)storehouse_id;
/*
 *  秒杀
 */
- (instancetype)initWithActivity_flash_id:(NSString *)activity_flash_id
                                 quantity:(NSString *)quantity
                          user_address_id:(NSString *)user_address_id
                            storehouse_id:(NSString *)storehouse_id;

/*
 *  积分
 */
- (instancetype)initWithWithScoreGoods_sku_id:(NSString *)goods_sku_id
                                     quantity:(NSString *)quantity
                              user_address_id:(NSString *)user_address_id
                                        score:(NSString *)score;
/*
 *  加入合伙人
 */
- (instancetype)initWithJoinPartner_pre_id:(int)nOrder_id;

- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)startToPayWithSelectedPayment;

/*
 *  获取订单详情vm
 */
- (id)fetchRootPopOrderDetailVM;

@end
