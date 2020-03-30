//
//  ConrimDetailGoodsItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCellViewModel.h"

@class OrderDetailGoodsModel;

@interface OrderDetailGoodsItemViewModel : LYProductItemBaseCellViewModel

@property (nonatomic,copy) NSString *quantity;

- (instancetype)initWithModel:(OrderDetailGoodsModel *)model;

@end
