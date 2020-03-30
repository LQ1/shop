//
//  OrderDetailDeliveryCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailDeliveryCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *delivery_id;
@property (nonatomic,copy) NSString *delivery_no;
@property (nonatomic,copy) NSString *delivery_name;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
