//
//  ConfirmOrderListAmountCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ConfirmOrderListAmountCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) NSInteger productTotalNumber;
@property (nonatomic,copy) NSString *productTotalPrice;

@end
