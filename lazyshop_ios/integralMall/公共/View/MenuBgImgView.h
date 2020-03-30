//
//  MenuBgImgView.h
//  MobileClassPhone
//
//  Created by zln on 16/4/22.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,cornerType)  {
    cornerType_middle = 0,  // 尖角在中间
    cornerType_left,        // 尖角在左边
    cornerType_right,       // 尖角在右边
    cornerType_bottom,      // 尖角向下
    cornerType_no           // 没有尖角
};

@interface MenuBgImgView : UIView

@property (nonatomic, strong) UIColor *bgColor;

- (instancetype)initWithBgColor:(UIColor *)bgColor AndFrame:(CGRect)rect;

- (instancetype)initWithBgColor:(UIColor *)bgColor AndFrame:(CGRect)rect andCornerType:(cornerType)type cornerRadius:(CGFloat)radius;

@end
