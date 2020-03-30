//
//  GoodsDetailPostageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodsDetailPostageViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *postage;
@property (nonatomic,readonly)NSArray *goodsTagModels;

- (instancetype)initWithPostage:(NSString *)postage
                 goodsTagModels:(NSArray *)goodsTagModels;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
