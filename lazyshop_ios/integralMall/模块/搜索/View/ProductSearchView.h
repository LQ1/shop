//
//  ProductSearchView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductSearchViewModel;

@interface ProductSearchView : UIView

- (void)reloadDataWithViewModel:(ProductSearchViewModel *)viewModel;

@end
