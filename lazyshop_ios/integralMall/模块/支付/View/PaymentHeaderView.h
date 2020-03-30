//
//  PaymentHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaymentViewModel;

#define PaymentHeaderViewHeight 92.5f

@interface PaymentHeaderView : UIView

- (void)realodDataWithViewModel:(PaymentViewModel *)viewModel;

@end
