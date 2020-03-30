//
//  ConfirmOrderListBottomView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ConfirmOrderListBottomViewHeight 40.0f

@class ConfirmOrderViewModel;

@interface ConfirmOrderListBottomView : UIView

- (void)reloadDataWithViewModel:(ConfirmOrderViewModel *)viewModel;

@end
