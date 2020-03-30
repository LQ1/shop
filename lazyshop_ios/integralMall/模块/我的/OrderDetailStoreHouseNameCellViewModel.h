//
//  OrderDetailStoreHouseNameCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailStoreHouseNameCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *storehouse_name;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
