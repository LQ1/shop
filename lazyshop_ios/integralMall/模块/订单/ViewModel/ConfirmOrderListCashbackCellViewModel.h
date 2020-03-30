//
//  ConfirmOrderListCashbackCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ConfirmOrderListCashbackCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) NSInteger periodNumbers;
@property (nonatomic,assign) NSInteger periodInterval;
@property (nonatomic,copy) NSString *periodPercent;

@end
