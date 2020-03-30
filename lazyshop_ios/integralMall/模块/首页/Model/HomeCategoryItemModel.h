//
//  HomeCategoryItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface HomeCategoryItemModel : BaseStringProModel

@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *goods_cat_name;
@property (nonatomic,copy)NSString *goods_cat_id;
@property (nonatomic,copy)NSString *goods_cat_type;

@end
