//
//  LYAlertView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAlertView : UIView

/**
 自定义UIAlertView
 
 @param title 标题
 @param message 说明信息，必传参数
 @param titles 按钮标题，最多3个
 @param click 点击
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                       titles:(NSArray *)titles
                        click:(void(^)(NSInteger index))click;

/*
 *  显示
 */
- (void)show;
/*
 *  小时
 */
- (void)disappear;

@property (nonatomic, readonly) UIView *alertView;
@property (nonatomic, readonly) UIButton *cancelButton;
@property (nonatomic, readonly) UIButton *otherButton;
// 三个中间一个
@property (nonatomic, readonly) UIButton *centerButton;

/**
 *  点击外围消失
 */
@property (nonatomic, assign) BOOL isOutside;

@end
