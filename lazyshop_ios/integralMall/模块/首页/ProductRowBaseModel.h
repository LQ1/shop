//
//  ProductRowBaseModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ProductRowBaseModel : BaseStringProModel

@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *attr_values;
@property (nonatomic,copy) NSString *slogan;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *sell_end_at;
@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *sell_start_at;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *is_coupon;

@property (nonatomic,copy) NSString *activity_flash_id;
@property (nonatomic,copy) NSString *activity_bargain_id;
@property (nonatomic,copy) NSString *activity_group_id;

@end
