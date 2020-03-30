//
//  OrderDetailRoundItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface OrderDetailRefoundItemCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *order_detail_id;

- (instancetype)initWithOrder_detail_id:(NSString *)order_detail_id;

@end
