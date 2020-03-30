//
//  DLAlertShowView.h
//  Pods
//
//  Created by SL on 16/6/16.
//
//

#import "DLRotateView.h"

typedef NS_ENUM(NSInteger,View_Popup_Mode) {
    View_Popup_Mode_Center = 0,
    View_Popup_Mode_Down,
};

@interface DLAlertShowView : DLRotateView

/**
 显示在window中心的view
 
 @param alertView 将要显示的view，此view需要设置大小CGSize
 */
+ (void)showInView:(UIView *)alertView;

/**
 弹出框直接消失
 */
+ (void)disappear;

/**
 弹出框消失，消失之后回调
 
 @param done
 */
+ (void)disappear:(void(^)())done;

/**
 显示在window上的view
 
 @param alertView        将要显示的view，此view需要设置大小CGSize
 @param popupMode        弹出的方式
 @param outsideDisappear 点击view外部区域是否自动消失
 */
+ (void)showInView:(UIView *)alertView
         popupMode:(View_Popup_Mode)popupMode
  outsideDisappear:(BOOL)outsideDisappear;

/**
 显示在window上的view
 
 @param alertView 将要显示的view，此view需要设置大小CGSize
 @param popupMode 弹出的方式
 @param outside 点击view外部区域是否自动消失，消失之后回调
 */
+ (void)showInView:(UIView *)alertView
         popupMode:(View_Popup_Mode)popupMode
           outside:(void(^)())outside;

@end
