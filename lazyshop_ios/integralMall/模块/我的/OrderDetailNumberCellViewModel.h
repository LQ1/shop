//
//  ComfirmDetailNumberCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailNumberCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *created_at;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
