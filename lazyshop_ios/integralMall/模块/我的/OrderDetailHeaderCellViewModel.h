//
//  ConfirmDetailHeaderCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

#import "OrderDetailModel.h"

@interface OrderDetailHeaderCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) OrderStatus orderStatus;
@property (nonatomic,copy) NSString *timeTip;
@property (nonatomic,strong) OrderDetailModel *model;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
