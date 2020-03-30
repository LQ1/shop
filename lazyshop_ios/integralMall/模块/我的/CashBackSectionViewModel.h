//
//  CashBackSectionViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface CashBackSectionViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *order_detail_id;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *storeID;
@property (nonatomic,copy) NSString *storeName;

@property (nonatomic,assign) BOOL unfold;

@end
