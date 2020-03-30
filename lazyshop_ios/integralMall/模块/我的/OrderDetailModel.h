//
//  OrderDetailModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "OrderDetailGoodsModel.h"

@interface OrderDetailModel : BaseStringProModel

@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *order_type;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *delivery_price;
@property (nonatomic,copy) NSString *receiver;
@property (nonatomic,copy) NSString *receiver_mobile;
@property (nonatomic,copy) NSString *receiver_address_detail;
@property (nonatomic,copy) NSString *discount_price;
@property (nonatomic,copy) NSString *total_quantity;
@property (nonatomic,copy) NSString *pay_status;
@property (nonatomic,copy) NSString *delivery_status;
@property (nonatomic,copy) NSString *delivery_no;
@property (nonatomic,copy) NSString *delivery_name;
@property (nonatomic,copy) NSString *delivery_id;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *order_status;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *pay_over_at;
@property (nonatomic,strong) NSArray *order_detail;
// 取货仓
@property (nonatomic,assign) NSInteger storehouse_id;
@property (nonatomic,copy) NSString *storehouse_name;
@property (nonatomic,copy) NSString *storehouse_mobile;
@property (nonatomic,copy) NSString *storehouse_address;

// 优惠金额
@property (nonatomic,copy) NSString *subtract_price;
// 需付款
@property (nonatomic,copy) NSString *pay_total_price;
@property (nonatomic,copy) NSString *pay_total_score;

// 拼团
@property (nonatomic,copy) NSString *group_status;
@property (nonatomic,copy) NSString *group_left_time;
@property (nonatomic,copy) NSString *group_url;

@end
