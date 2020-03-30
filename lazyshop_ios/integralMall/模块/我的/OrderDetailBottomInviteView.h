//
//  OrderDetailBottomInviteView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OrderDetailBottomInviteViewHeight 44.0f

@interface OrderDetailBottomInviteView : UIView

@property (nonatomic,readonly)RACSubject *clickSignal;

- (instancetype)initCountDownSeconds:(NSInteger)seconds;

@end
