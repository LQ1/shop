//
//  MyBargainItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCellViewModel.h"

@interface MyBargainItemViewModel : LYProductItemBaseCellViewModel

@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *delivery_price;

@property (nonatomic,copy) NSString *bargain_url;
@property (nonatomic,copy) NSString *bargain_price;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *bargain_open_id;
@property (nonatomic,copy) NSString *activity_bargain_id;
@property (nonatomic,copy) NSString *storehouse_id;

@property (nonatomic,copy) NSString *pay_total_price;
@property (nonatomic,copy) NSString *group_url;
@property (nonatomic,copy) NSString *order_id;

@end
