//
//  CouponUseView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponUseViewModel;

@interface CouponUseView : UIView

- (void)reloadDataWithViewModel:(CouponUseViewModel *)viewModel;

@end
