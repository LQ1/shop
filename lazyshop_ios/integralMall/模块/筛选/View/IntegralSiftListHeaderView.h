//
//  IntegralSiftListHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SiftListViewModel;

#define IntegralSiftListHeaderViewBaseHeight 34.0f
#define IntegralSiftListHeaderViewWholeHeight 145.0f

@interface IntegralSiftListHeaderView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;
@property (nonatomic,readonly) CGFloat headerHeight;
@property (nonatomic,readonly) UITextField *minScoreInputView;
@property (nonatomic,readonly) UITextField *maxScoreInputView;

- (void)reloadDataWithViewModel:(SiftListViewModel *)viewModel;

- (void)endInputEditting;

@end
