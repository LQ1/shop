//
//  PayResultView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayResultViewModel;

@interface PayResultView : UIView

@property (nonatomic, readonly) UITableView *mainTable;

- (void)reloadDataWithViewModel:(PayResultViewModel *)viewModel;

@end
