//
//  ConfirmOrderListCouponCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ConfirmOrderListCouponCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) NSInteger validCouponNumber;
@property (nonatomic,copy) NSString *currentUseCouponID;
@property (nonatomic,copy) NSString *currentMoneyValue;

@end
