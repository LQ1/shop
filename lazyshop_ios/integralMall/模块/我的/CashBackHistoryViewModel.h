//
//  CashBackHistoryViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface CashBackHistoryViewModel : LYBaseViewModel

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
