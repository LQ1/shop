//
//  HomeRecommendCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface HomeRecommendCellViewModel : LYItemUIBaseViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
