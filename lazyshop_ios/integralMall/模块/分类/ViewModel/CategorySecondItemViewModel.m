//
//  CategorySecondItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategorySecondItemViewModel.h"

#import "CategoryModel.h"

#import "CategoryThirdItemViewModel.h"
#import "ProductListViewModel.h"

@implementation CategorySecondItemViewModel

- (instancetype)initWithCategoryModel:(CategoryModel *)model
{
    self = [super init];
    if (self) {
        self.secondCategoryID = [NSString stringWithFormat:@"%ld",(long)model.goods_cat_id];
        self.secondCategoryName = model.title;
        NSMutableArray *resultArray = [NSMutableArray array];
        [model.child enumerateObjectsUsingBlock:^(CategoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CategoryThirdItemViewModel *thirdVM = [[CategoryThirdItemViewModel alloc] initWithCategoryModel:obj];
            [resultArray addObject:thirdVM];
        }];
        self.thirdItemVMs = [NSArray arrayWithArray:resultArray];
    }
    return self;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.thirdItemVMs.count;
}

- (CategoryThirdItemViewModel *)viewModelForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.thirdItemVMs objectAtIndex:indexPath.row];
}

- (id)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryThirdItemViewModel *itemVM = [self.thirdItemVMs objectAtIndex:indexPath.row];
    ProductListViewModel *listVM = [[ProductListViewModel alloc] initWithCartType:itemVM.cat_type
                                                                     goods_cat_id:itemVM.thirdCategoryID
                                                                      goods_title:nil];
    return listVM;
}

@end
