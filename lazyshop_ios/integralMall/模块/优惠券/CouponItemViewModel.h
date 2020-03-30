//
//  GoodsDetailCouponItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

typedef NS_ENUM(NSInteger,GoodsDetailCouponState)
{
    GoodsDetailCouponState_CanReceive = 0,
    GoodsDetailCouponState_Received,
    GoodsDetailCouponState_NoneToReceive,
    GoodsDetailCouponState_CanBeUsed,
    GoodsDetailCouponState_Overdue,
    GoodsDetailCouponState_Used
};

@interface CouponItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign)GoodsDetailCouponState couponState;
@property (nonatomic,copy)NSString *couponID;
@property (nonatomic,copy)NSString *user_coupon_id;
@property (nonatomic,copy)NSString *moneyValue;
@property (nonatomic,copy)NSString *tipMsg1;
@property (nonatomic,copy)NSString *tipMsg2;
@property (nonatomic,copy)NSString *validTime;
@property (nonatomic,copy)NSString *goods_cat_id;

@property (nonatomic,assign)BOOL checkBoxStyle;
@property (nonatomic,assign)BOOL selected;

- (instancetype)initWithCouponID:(NSString *)couponID
                  user_coupon_id:(NSString *)user_coupon_id
                      moneyValue:(NSString *)moneyValue
                         tipMsg1:(NSString *)tipMsg1
                         tipMsg2:(NSString *)tipMsg2
                       validTime:(NSString *)validTime
                    goods_cat_id:(NSString *)goods_cat_id
                   checkBoxStyle:(BOOL)checkBoxStyle
                     couponState:(GoodsDetailCouponState)state;

@end
