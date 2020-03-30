//
//  UIView+Frame.h
//  Sinfo
//
//  Created by xiaoyu on 16/6/29.
//  Copyright © 2016年 YaoZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SKOscillatoryAnimationToBigger,
    SKOscillatoryAnimationToSmaller,
} SKOscillatoryAnimationType;

@interface UIView (Frame)
@property (nonatomic) CGFloat lyLeft;
@property (nonatomic) CGFloat lyTop;
@property (nonatomic) CGFloat lyRight;
@property (nonatomic) CGFloat lyBottom;
@property (nonatomic) CGFloat lyWidth;
@property (nonatomic) CGFloat lyHeight;
@property (nonatomic) CGFloat lyCenterX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat lyCenterY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint lyOrigin;
@property (nonatomic) CGSize lySize;
@property (nonatomic, readonly) CGFloat lyScreenX;
@property (nonatomic, readonly) CGFloat lyScreenY;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(SKOscillatoryAnimationType)type;
@end
