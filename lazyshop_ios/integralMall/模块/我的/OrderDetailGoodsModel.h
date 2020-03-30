//
//  OrderDetailGoodsModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface OrderDetailGoodsModel : BaseStringProModel

@property (nonatomic,copy) NSString *order_detail_id;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *total_price;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *total_score;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *pay_price;
@property (nonatomic,copy) NSString *goods_title;
@property (nonatomic,copy) NSString *attr_values;
@property (nonatomic,copy) NSString *goods_thumb;
@property (nonatomic,copy) NSString *order_type;

@end
