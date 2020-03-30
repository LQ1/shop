//
//  MyOrderlistProductViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCellViewModel.h"

#import "MyOrderItemModel.h"

@interface MyOrderlistProductViewModel : LYProductItemBaseCellViewModel

@property (nonatomic,strong)MyOrderItemModel *model;

- (instancetype)initWithModel:(MyOrderItemModel *)model;

@end
