//
//  CategoryThirdItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CategoryModel;

@interface CategoryThirdItemViewModel : BaseViewModel

- (instancetype)initWithCategoryModel:(CategoryModel *)model;

@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *thirdCategoryName;
@property (nonatomic,copy)NSString *thirdCategoryID;
@property (nonatomic,copy) NSString *cat_type;

@end
