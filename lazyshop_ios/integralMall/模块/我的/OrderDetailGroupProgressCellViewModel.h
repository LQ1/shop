//
//  OrderDetailGroupProgressCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailGroupProgressCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *group_url;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
