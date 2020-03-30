//
//  LYHeaderSwitchView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHeaderSwitchView : UIView

@property (nonatomic,readonly)RACSubject *clickSignal;

/*
 *  均分模式
 */
@property (nonatomic,assign)BOOL divideStyle;

- (instancetype)initWithHeight:(CGFloat)height;

/*
 *  刷新布局 一般只可以调用一次 否则会有问题
 */
- (void)reloadDataWithItemViewModels:(NSArray *)itemViewModels;
/*
 *  仅仅刷新内容 不刷新布局
 */
- (void)reload;

@end
