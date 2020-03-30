//
//  CategoryFirstItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CategoryModel;
@class CategorySecondItemViewModel;

@interface CategoryFirstItemViewModel : BaseViewModel

@property (nonatomic,copy)NSString *firstCategoryName;
@property (nonatomic,copy)NSString *firstCategoryID;
@property (nonatomic,assign)BOOL selected;

@property (nonatomic,strong)NSArray *secondItemVMs;

- (instancetype)initWithCategoryModel:(CategoryModel *)model;

- (NSInteger)numberOfSections;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (CategorySecondItemViewModel *)secondItemVMInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CategorySecondItemViewModel *)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
