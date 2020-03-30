//
//  HomeActivityBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class HomeActivityBaseModel;

@interface HomeActivityBaseViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *slogan;

/*
 *  初始化
 */
- (instancetype)initWithItemModels:(NSArray *)itemModels;

- (NSInteger)itemCountAtSection:(NSInteger)section;
- (HomeActivityBaseModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
