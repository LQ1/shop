//
//  ProductListItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface ProductListItemModel : BaseModel

@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,copy)NSString *goods_cat_id;
@property (nonatomic,copy)NSString *goods_title;
@property (nonatomic,copy)NSString *thumb;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,assign)NSInteger is_coupon;
@property (nonatomic,copy)NSString *slogan;


@end
