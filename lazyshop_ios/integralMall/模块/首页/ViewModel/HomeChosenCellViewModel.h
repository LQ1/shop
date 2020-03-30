//
//  HomeChosenCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class ProductListItemViewModel;

@interface HomeChosenCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,strong)NSArray *itemModels;
@property (nonatomic,assign)BOOL usedForRecommend;

- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (void)resetCellHeight;

- (NSInteger)itemCountAtSection:(NSInteger)section;
- (ProductListItemViewModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
