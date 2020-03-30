//
//  GoodsAttrModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface GoodsAttrModel : BaseStringProModel

@property (nonatomic,copy) NSString *goods_attr_id;
@property (nonatomic,copy) NSString *goods_attr_name;
@property (nonatomic,strong) NSArray *values;

@end
