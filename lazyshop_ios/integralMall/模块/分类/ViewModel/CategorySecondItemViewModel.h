//
//  CategorySecondItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CategoryModel;
@class CategoryThirdItemViewModel;

@interface CategorySecondItemViewModel : BaseViewModel

@property (nonatomic,copy)NSString *secondCategoryName;
@property (nonatomic,copy)NSString *secondCategoryID;

@property (nonatomic,strong)NSArray *thirdItemVMs;

- (instancetype)initWithCategoryModel:(CategoryModel *)model;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (CategoryThirdItemViewModel *)viewModelForItemAtIndexPath:(NSIndexPath *)indexPath;
- (id)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
