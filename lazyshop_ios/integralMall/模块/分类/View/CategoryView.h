//
//  CategoryView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategroyViewModel;

@interface CategoryView : UIView

/*
 *  数据刷新
 */
- (void)reloadDataWithViewModel:(CategroyViewModel *)viewModel;

@end
