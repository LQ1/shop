//
//  HomeHoriScrollBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface HomeHoriScrollBaseViewModel : LYItemUIBaseViewModel

/*
 *  初始化
 */
- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (NSInteger)itemCountAtSection:(NSInteger)section;
- (id)itemModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
