//
//  PayResultViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,PayResultViewModel_SignalType)
{
    PayResultViewModel_SignalType_FetchGoodsSuccess = 0,
    PayResultViewModel_SignalType_FetchGoodsFailed,
    PayResultViewModel_SignalType_GotoGoodsDetail,
    PayResultViewModel_SignalType_CheckOrder,
    PayResultViewModel_SignalType_PayAgain
};

@interface PayResultViewModel : BaseViewModel

@property (nonatomic,assign)PayResultViewModel_SignalType currentSignalType;

@property (nonatomic,assign)NSInteger oldDataCount;

@property (nonatomic,assign) BOOL paySuccess;
@property (nonatomic,assign) PayMentType payMentType;
@property (nonatomic,copy) NSString *payValue;

- (instancetype)initWithPaySuccess:(BOOL)paySuccess
                       payMentType:(PayMentType)paymentType
                          payValue:(NSString *)payValue
                          order_id:(NSString *)orderID;

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;

// 商品详情
- (void)gotoGoodsDetailWithVM:(id)vm;
// 查看订单/重新支付
- (void)checkBtnClick;

@end
