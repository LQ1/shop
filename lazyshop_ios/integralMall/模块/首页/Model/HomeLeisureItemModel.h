//
//  HomeLeisureItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface HomeLeisureItemModel : BaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger goods_cat_id;
@property (nonatomic, copy) NSString *goods_cat_name;
@property (nonatomic, assign) NSInteger goods_cat_type;

@end
