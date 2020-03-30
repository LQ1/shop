//
//  MyRefoundItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

#import "MyRefoundItemModel.h"

@interface MyRefoundItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) MyRefoundItemModel *model;

- (instancetype)initWithModel:(MyRefoundItemModel *)model;

@end
