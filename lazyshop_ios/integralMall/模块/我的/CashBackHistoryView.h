//
//  CashBackHistoryView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class CashBackHistoryViewModel;

@interface CashBackHistoryView : AutoTableView

- (void)reloadDataWithViewModel:(CashBackHistoryViewModel *)viewModel;

@end
