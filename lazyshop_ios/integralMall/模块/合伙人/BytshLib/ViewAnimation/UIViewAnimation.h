//
//  UIViewAnimation.h
//  test


/*animationwithkeypath  动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。动画的实现不能放在viewDid中。。。
transform.scale = 比例轉換

transform.scale.x = 闊的比例轉換

transform.scale.y = 高的比例轉換

transform.rotation.z = 平面圖的旋轉

opacity = 透明度

margin = 布局

zPosition = 翻转

backgroundColor = 背景颜色

cornerRadius = 圆角

borderWidth = 边框宽

bounds = 大小

contents = 内容

contentsRect = 内容大小

cornerRadius = 圆角

frame = 大小位置

hidden = 显示隐藏

mask

masksToBounds

opacity

position

shadowColor

shadowOffset

shadowOpacity

shadowRadius

*/

/*
// 移动
CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
// 动画选项的设定
animation.duration = 2.5; // 持续时间
animation.repeatCount = 1; // 重复次数
// 起始帧和终了帧的设定
animation.fromValue = [NSValue valueWithCGPoint:myView.layer.position]; // 起始帧
animation.toValue = [NSValue valueWithCGPoint:CGPointMake(320, 480)]; // 终了帧
 // 添加动画
 [myView.layer addAnimation:animation forKey:@"move-layer"];
 */

/* 动画组
//CAAnimationGroup *group = [CAAnimationGroup animation];
// 动画选项设定
group.duration = 3.0;
group.repeatCount = 1;

// 添加动画
group.animations = [NSArray arrayWithObjects:animation1, animation2, nil nil];
[myView.layer addAnimation:group forKey:@"move-rotate-layer"];
 */


//
//  Created by liu on 17/2/1.
//  Copyright © 2017年 bytsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//动画效果枚举
typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;


@interface UIViewAnimation : NSObject{
    int _subtype;
}

@property BOOL isShowInnterViewAnimation;
@property AnimationType animationType;

- (void)showViewAnimation:(AnimationType)aniType withSelfView:(UIView*)view;



@end
