//
//  FeedBackTypeSwitchView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackTypeSwitchView : UIView

@property (nonatomic,readonly)RACSubject *clickSignal;

- (instancetype)initWithHeight:(CGFloat)height;

/*
 *  刷新布局 一般只可以调用一次 否则会有问题
 */
- (void)reloadDataWithItemViewModels:(NSArray *)itemViewModels;

@end
