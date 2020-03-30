//
//  DeliveryItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface DeliveryItemCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *accept_station;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *accept_time;

- (instancetype)initWithAccept_station:(NSString *)accept_station
                                remark:(NSString *)remark
                           accept_time:(NSString *)accept_time;

@end
