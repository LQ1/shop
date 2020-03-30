//
//  ConfrimOrderCouponModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ConfrimOrderCouponModel : BaseStringProModel

@property (nonatomic,copy) NSString *coupon_total;
@property (nonatomic,strong) NSArray *coupon_list;

@end
