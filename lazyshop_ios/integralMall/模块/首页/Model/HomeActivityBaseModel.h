//
//  HomeActivityBaseModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface HomeActivityBaseModel : BaseStringProModel

@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *thumb;
@property (nonatomic,copy)NSString *slogan;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,copy)NSString *goods_sku_id;

@end
