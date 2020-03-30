//
//  MyOrderModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "MyOrderItemModel.h"

@interface MyOrderModel : BaseStringProModel

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *order_type;
@property (nonatomic,copy) NSString *delivery_price;
@property (nonatomic,copy) NSString *total_quantity;
@property (nonatomic,copy) NSString *pay_total_price;
@property (nonatomic,copy) NSString *pay_total_score;
@property (nonatomic,copy) NSString *pay_status;
@property (nonatomic,copy) NSString *delivery_status;
@property (nonatomic,copy) NSString *order_status;
@property (nonatomic,strong) NSArray *order_detail;

@end
