//
//  GoodsDetailViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class GoodsDetailViewModel;

@interface GoodsDetailViewController : NavigationBarController

@property BOOL propertyIsEnterFromMakeMoney;

@property (nonatomic,strong)GoodsDetailViewModel *viewModel;

@end
