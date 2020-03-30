//
//  MyCouponPageModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "CouponModel.h"

@interface MyCouponPageModel : BaseStringProModel

@property (nonatomic,copy) NSString *available_total;
@property (nonatomic,copy) NSString *not_use_total;
@property (nonatomic,strong) NSArray *coupon;

@end
