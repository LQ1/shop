//
//  ConfirmOrderListIntegralCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ConfirmOrderListIntegralCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) BOOL supportIntegral;
@property (nonatomic,copy) NSString *useScore;
@property (nonatomic,copy) NSString *userInputScore;

@end
