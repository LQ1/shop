//
//  MyScoreHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyScoreHeaderViewHeight 172.0f

@class MyScoreViewModel;

@interface MyScoreHeaderView : UIView

@property (nonatomic, readonly) RACSubject *gotoSignSingal;

- (void)reloadDataWithViewModel:(MyScoreViewModel *)viewModel;

@end
