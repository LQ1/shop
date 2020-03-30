//
//  ProductSearchViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

#import "ProductSearchMacro.h"

@class ProductSearchViewModel;

@interface ProductSearchViewController : NavigationBarController

@property (nonatomic,strong ) ProductSearchViewModel *viewModel;

- (instancetype)initWithSearchBackBlock:(searchTitleBackBlock)block;

@end
