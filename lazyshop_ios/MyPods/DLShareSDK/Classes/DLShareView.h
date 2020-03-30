//
//  DLShareView.h
//  DLShareSDK
//
//  Created by LY on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    animateDirectionNone = 0,   // 无方向
    animateDirectionFromBottom, // 自下到上
    animateDirectionFromTop,    // 自上到下
    animateDirectionFromLeft,   // 自左到右
    animateDirectionFromRight   // 自右到左
}animateDirection;

@interface DLShareView : UIView

/**
 *  出现动画的方向 上下左右的平移效果 
 *  若想其他动画请自定义下面2个属性
 *  默认无
 */
@property (nonatomic,assign)animateDirection appearDirection;

/**
 *  定义视图出现的动画
 */
@property (nonatomic,assign)CAAnimation *apperAnimation;
/**
 *  定义视图消失的动画
 */
@property (nonatomic,assign)CAAnimation *disapperAnimation;

/**
 *  QQ
 */
@property (nonatomic,strong)UIButton *qqButton;
/**
 *  QQ空间
 */
@property (nonatomic,strong)UIButton *qzoneButton;
/**
 *  微信好友
 */
@property (nonatomic,strong)UIButton *wxFriendButton;
/**
 *  微信朋友圈
 */
@property (nonatomic,strong)UIButton *wxGroupButton;

@end
