//
//  ComfirmDetailTotalMoneyCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailTotalMoneyCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *payMoney;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
