//
//  OrderDetailViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"


typedef NS_ENUM(NSInteger, OrderDetailViewModel_Signal_Type)
{
    OrderDetailViewModel_Signal_Type_GetRecommentSuccess = 0,
    OrderDetailViewModel_Signal_Type_GetRecommentFailed,
    OrderDetailViewModel_Signal_Type_GotoGoodsDetail,
    OrderDetailViewModel_Signal_Type_GotoDeliveryTrack,
    OrderDetailViewModel_Signal_Type_GotoPop,
    OrderDetailViewModel_Signal_Type_GotoPayment
};

@interface OrderDetailViewModel : LYBaseViewModel

@property (nonatomic,assign)NSInteger oldDataCount;
@property (nonatomic,assign)BOOL rootPop;

@property (nonatomic,copy) NSString *orderTitle;
@property (nonatomic,assign) OrderType orderType;
@property (nonatomic,assign) NSInteger group_left_time;
@property (nonatomic,readonly)OrderStatus order_status;

- (instancetype)initWithOrderID:(NSString *)order_id
                     orderTitle:(NSString *)orderTitle;

- (void)getRecommentd:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 *  跳转商品详情
 */
- (void)gotoGoodsDetailWithVM:(id)vm;
/*
 *  跳转订单追踪
 */
- (void)gotoDeliveryTrackWithVM:(id)vm;

/*
 *  拼团邀请好友
 */
- (void)inviteFriends;

/*
 *  申请售后
 */
- (void)applyAfterSaleServiceWithOrder_detail_id:(NSString *)order_detail_id;

- (void)deleteOrder;
- (void)confirmOrder;
- (void)cancelOrder;
- (void)payOrder;

@end
