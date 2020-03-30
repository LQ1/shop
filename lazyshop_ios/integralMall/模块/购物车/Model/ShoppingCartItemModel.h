//
//  ShoppingCartItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ShoppingCartItemModel : BaseStringProModel

@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *goods_cart_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *attr_values;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *status;



@end
