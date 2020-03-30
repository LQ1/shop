//
//  ConfirmOrderModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "ConfrimOrderCouponModel.h"
#import "ShippingAddressModel.h"
#import "ConfirmOrderGoodsDetailModel.h"
#import "CouponModel.h"

@interface ConfirmOrderModel : BaseStringProModel

@property (nonatomic,strong) ShippingAddressModel *user_address;
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,copy) NSString *postage;

@property (nonatomic,strong) ConfrimOrderCouponModel *coupon;
@property (nonatomic,copy) NSString *goods_cart_id;


@end
