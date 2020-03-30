//
//  UIViewAnimation.m
//  test
//
//  Created by liu on 17/2/1.
//  Copyright © 2017年 bytsh. All rights reserved.
//

#import "UIViewAnimation.h"

#define DURATION 0.7f

@implementation UIViewAnimation


//显示窗体切换动画
- (void)showViewAnimation:(AnimationType)aniType withSelfView:(UIView*)view{
    self.animationType = aniType;
    [self showSwitchAnimation:view];
}


//窗体进入动画
- (void)showSwitchAnimation:(UIView*)view{
    //随机动画
    NSString *subtypeString;
    
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }
    switch (self.animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:view];
            break;
        
        case CurlDown:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
}


#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    if (self.isShowInnterViewAnimation) {
        [view.layer addAnimation:animation forKey:@"animation"];
    }else{
        [view.window.layer addAnimation:animation forKey:@"animation"];
    }
    
}



#pragma UIView实现动画


- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    /*
     [UIView animateWithDuration:DURATION animations:^{
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     [UIView setAnimationTransition:transition forView:view cache:YES];
     }];*/
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }completion:^(BOOL finished){
    }];
}


@end
