//
//  GroupBuyListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class LYBaseViewModel;

@interface GroupBuyListView : AutoTableView

- (void)reloadDataWithViewModel:(LYBaseViewModel *)viewModel;

@end
