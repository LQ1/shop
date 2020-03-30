//
//  CouponModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface CouponModel : BaseStringProModel

@property (nonatomic,copy) NSString *coupon_id;
@property (nonatomic,copy) NSString *coupon_title;
@property (nonatomic,copy) NSString *coupon_description;
@property (nonatomic,copy) NSString *coupon_price;
@property (nonatomic,copy) NSString *use_start_at;
@property (nonatomic,copy) NSString *use_end_at;
@property (nonatomic,copy) NSString *coupon_status;

// 已领取的优惠券
@property (nonatomic,copy) NSString *user_coupon_id;

// 我的优惠券
@property (nonatomic,copy) NSString *goods_cat_id;

@end
