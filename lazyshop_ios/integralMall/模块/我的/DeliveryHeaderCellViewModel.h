//
//  DeliveryHeaderCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface DeliveryHeaderCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *delivery_no;
@property (nonatomic,copy) NSString *delivery_name;

- (instancetype)initWithDelivery_no:(NSString *)delivery_no
                      delivery_name:(NSString *)delivery_name;

@end
