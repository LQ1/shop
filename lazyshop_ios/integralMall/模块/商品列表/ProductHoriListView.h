//
//  ProductHoriListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductListViewModel;

@interface ProductHoriListView : UIView

@property (nonatomic,readonly)UITableView *mainTable;

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel;

@end
