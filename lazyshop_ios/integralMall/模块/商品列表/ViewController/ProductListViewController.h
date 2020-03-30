//
//  ProductListViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class ProductListViewModel;

@interface ProductListViewController : NavigationBarController

@property BOOL propertyIsEnterFromMakeMoney;

@property (nonatomic,strong)ProductListViewModel *viewModel;

@end
