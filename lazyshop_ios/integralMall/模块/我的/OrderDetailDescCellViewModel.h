//
//  ComfirmDetailDescCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailDescCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *goodsTotalPrice;
@property (nonatomic,copy) NSString *integralDiscountPrice;
@property (nonatomic,copy) NSString *postage;
@property (nonatomic,copy) NSString *orderTotalPrice;
@property (nonatomic,copy) NSString *subtract_price;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
