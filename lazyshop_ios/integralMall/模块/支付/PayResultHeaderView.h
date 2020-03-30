//
//  PayResultHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PayResultHeaderViewHeight 195.0f

@class PayResultViewModel;

@interface PayResultHeaderView : UIView

- (void)reloadDataWithViewModel:(PayResultViewModel *)viewModel;

@end
