//
//  HomeCycleScrollCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface HomeCycleScrollCellViewModel : LYItemUIBaseViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (NSString *)imgUrlAtIndex:(NSInteger)index;

- (NSInteger)linkTypeAtIndex:(NSInteger)index;
- (NSString *)linkUrlAtIndex:(NSInteger)index;
- (id)linkModelAtIndex:(NSInteger)index;

- (NSInteger)itemsCount;

@end
