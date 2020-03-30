//
//  MyOrdersView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class MyOrdersViewModel;

@interface MyOrdersView : AutoTableView

- (instancetype)initWithViewModel:(MyOrdersViewModel *)viewModel;

- (void)getData;

@end
