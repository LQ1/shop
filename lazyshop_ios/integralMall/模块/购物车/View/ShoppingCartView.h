//
//  ShoppingCartView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartViewModel;

@interface ShoppingCartView : UIView

@property (nonatomic,readonly)UITableView *mainTable;

- (instancetype)initWithUsedForPush:(BOOL)usedForPush;

- (void)reloadDataWithViewModel:(ShoppingCartViewModel *)viewModel;

@end
