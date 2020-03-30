//
//  OrderDetailBottomActionView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OrderDetailBottomActionViewHeight 44.0f

@class OrderDetailViewModel;

typedef NS_ENUM(NSInteger,OrderDetailBottomActionType)
{
    OrderDetailBottomActionType_DeleteOrder = 0,
    OrderDetailBottomActionType_PayOrder,
    OrderDetailBottomActionType_CancelOrder,
    OrderDetailBottomActionType_ConfirmOrder
};

@interface OrderDetailBottomActionView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;

- (void)bindViewModel:(OrderDetailViewModel *)viewModel;

@end
