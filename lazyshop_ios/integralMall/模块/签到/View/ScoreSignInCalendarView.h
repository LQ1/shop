//
//  ScoreSignInCalendarView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScoreSignInViewModel;

@interface ScoreSignInCalendarView : UIView

- (void)reloadDataWithViewModel:(ScoreSignInViewModel *)viewModel;

@end
