//
//  MyScoreView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyScoreViewModel;

@interface MyScoreView : UIView

- (instancetype)initWithViewModel:(MyScoreViewModel *)viewModel;

- (void)reloadDataWithViewModel:(MyScoreViewModel *)viewModel;

@end
