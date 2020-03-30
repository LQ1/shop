//
//  HomeCategoryCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class HomeCategoryItemModel;

@interface HomeCategoryCellViewModel : LYItemUIBaseViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (NSInteger)itemCountAtSection:(NSInteger)section;
- (HomeCategoryItemModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
