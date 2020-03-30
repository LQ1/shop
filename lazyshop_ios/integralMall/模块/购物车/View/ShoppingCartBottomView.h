//
//  ShoppingCartBottomView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartViewModel;

#define ShoppingCartBottomViewHeight 40.0f

@interface ShoppingCartBottomView : UIView

- (void)reloadDataWithViewModel:(ShoppingCartViewModel *)viewModel;

@end
