//
//  CategoryRightHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategorySecondItemViewModel;

@interface CategoryRightHeaderView : UITableViewHeaderFooterView

- (void)reloadDataWithViewModel:(CategorySecondItemViewModel *)viewModel;

@end
