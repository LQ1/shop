//
//  ScoreSignInHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScoreSignInHeaderViewHeight iPhone4?80.0f:150.0f

@class ScoreSignInViewModel;

@interface ScoreSignInHeaderView : UIView

- (void)reloadDataWithViewModel:(ScoreSignInViewModel *)viewModel;

@end
