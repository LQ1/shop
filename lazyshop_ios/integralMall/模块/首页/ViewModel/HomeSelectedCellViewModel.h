//
//  HomeSelectedCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeHoriScrollBaseViewModel.h"

#import "HomeSelectedRecomModel.h"

@interface HomeSelectedCellViewModel : HomeHoriScrollBaseViewModel

@property (nonatomic, strong) HomeSelectedRecomModel *model;

- (instancetype)initSelectedModels:(NSArray *)selecteds
                        recomModel:(HomeSelectedRecomModel *)model;

- (id)recommedModelAtIndex:(NSInteger)index;

@end
