//
//  MyOrderListItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

#import "MyOrderModel.h"

@interface MyOrderListItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,strong)MyOrderModel *model;

- (instancetype)initWithModel:(MyOrderModel *)model;

@end
