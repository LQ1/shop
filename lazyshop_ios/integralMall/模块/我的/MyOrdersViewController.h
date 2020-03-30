//
//  MyOrdersViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class MyOrdersViewModel;

@interface MyOrdersViewController : NavigationBarController

@property (nonatomic,strong)MyOrdersViewModel *viewModel;

@end
