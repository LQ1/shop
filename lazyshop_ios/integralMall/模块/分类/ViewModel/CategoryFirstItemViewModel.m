//
//  CategoryFirstItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryFirstItemViewModel.h"

#import "CategoryModel.h"

#import "CategorySecondItemViewModel.h"
#import "CategoryViewMacro.h"

@implementation CategoryFirstItemViewModel

- (instancetype)initWithCategoryModel:(CategoryModel *)model
{
    self = [super init];
    if (self) {
        self.firstCategoryID = [NSString stringWithFormat:@"%ld",(long)model.goods_cat_id];
        self.firstCategoryName = model.title;
        NSMutableArray *resultArray = [NSMutableArray array];
        [model.child enumerateObjectsUsingBlock:^(CategoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CategorySecondItemViewModel *secondVM = [[CategorySecondItemViewModel alloc] initWithCategoryModel:obj];
            [resultArray addObject:secondVM];
        }];
        self.secondItemVMs = [NSArray arrayWithArray:resultArray];
    }
    return self;
}

- (NSInteger)numberOfSections
{
    return self.secondItemVMs.count;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return CategoryRightSectionHeaderHeight;
}

- (CategorySecondItemViewModel *)secondItemVMInSection:(NSInteger)section
{
    return [self.secondItemVMs objectAtIndex:section];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategorySecondItemViewModel *secondItemVM = [self viewModelForRowAtIndexPath:indexPath];
    if (secondItemVM.thirdItemVMs.count == 0) {
        return 0.0001;
    }
    NSInteger rowCount = (secondItemVM.thirdItemVMs.count-1)/CategoryRightRowItemMaxCount+1;
    return CategoryRightSectionTopGap*2 + rowCount*CategoryRightItemHeight + (rowCount-1)*CategoryRightItemVerGap;
}

- (CategorySecondItemViewModel *)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategorySecondItemViewModel *secondItemVM = [self.secondItemVMs objectAtIndex:indexPath.section];
    return secondItemVM;
}

@end
