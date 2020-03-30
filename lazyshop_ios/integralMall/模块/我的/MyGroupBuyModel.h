//
//  MyGroupBuyModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface MyGroupBuyModel : BaseStringProModel

@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *goods_title;
@property (nonatomic,copy) NSString *delivery_price;
@property (nonatomic,copy) NSString *group_join_id;
@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy) NSString *group_open_id;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *pay_total_price;
@property (nonatomic,copy) NSString *total_quantity;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *attr_values;
@property (nonatomic,copy) NSString *group_url;

@end
