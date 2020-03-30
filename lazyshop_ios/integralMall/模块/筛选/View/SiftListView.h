//
//  SiftListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SiftListViewModel;

#import "IntegralSiftListHeaderView.h"

@interface SiftListView : UIView

@property (nonatomic,readonly)IntegralSiftListHeaderView *headerView;

- (void)reloadDataWithViewModel:(SiftListViewModel *)viewModel;

@end
