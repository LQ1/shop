//
//  LYMainView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYBaseViewModel;

@interface LYMainView : UIView

- (void)reloadDataWithViewModel:(LYBaseViewModel *)viewModel;

@end
