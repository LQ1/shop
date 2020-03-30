//
//  ConfirmOrderHeadAdressView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfirmOrderViewModel;

#define ConfirmOrderHeadAdressViewHeight 90.0f

@interface ConfirmOrderHeadAdressView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;

- (void)reloadDataWithViewModel:(ConfirmOrderViewModel *)viewModel;

@end
