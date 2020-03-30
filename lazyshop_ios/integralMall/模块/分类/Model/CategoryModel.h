//
//  CategoryModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface CategoryModel : BaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *parent_id;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *cat_type;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,assign) NSInteger goods_cat_id;
@property (nonatomic,strong) NSArray *child;

@end
