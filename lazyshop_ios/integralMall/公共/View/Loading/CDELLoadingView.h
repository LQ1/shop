//
//  CDELLoadingView.h
//  MobileClassPhone
//  正保加载View
//  Created by SL on 14-4-13.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 刷新类型
 */
typedef NS_ENUM(NSInteger,CDELLoadingType) {
    //加载中
    CDELLoading = 8534,
    //加载失败，可重新加载
    CDELLoadingCycle,
    //加载完成，没有数据显示，不需要重新加载，友好提示
    CDELLoadingDone,
    //加载完成，不显示加载框
    CDELLoadingRemove,
    //自定义提示图片
    CDELLoadingCustom,
};

@interface CDELLoadingView : UIView

/**
 显示加载框，可重复加载
 
 @param type        加载类型
 @param cycle       重复加载执行的方法
 @param title       显示的提示名称
 @param buttonTitle 重试按钮名称
 @param customImage 自定义提示图片的名称
 */
- (void)showCDELLoadingView:(CDELLoadingType)type
                      cycle:(void(^)())cycle
                      title:(NSString *)title
                buttonTitle:(NSString *)buttonTitle
                customImage:(NSString *)customImage;

@end
