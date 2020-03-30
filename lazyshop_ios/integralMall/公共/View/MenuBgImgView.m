//
//  MenuBgImgView.m
//  MobileClassPhone
//
//  Created by zln on 16/4/22.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "MenuBgImgView.h"

@implementation MenuBgImgView

{
    cornerType   _cornerType;        // 本实例尖角的指向类型
    CGFloat      _radius;        // 圆角半径

}

- (instancetype)initWithBgColor:(UIColor *)bgColor AndFrame:(CGRect)rect {
    return [self initWithBgColor:bgColor AndFrame:rect andCornerType:cornerType_right cornerRadius:4];
}

- (instancetype)initWithBgColor:(UIColor *)bgColor AndFrame:(CGRect)rect andCornerType:(cornerType)type cornerRadius:(CGFloat)radius{
    if (self = [super initWithFrame:rect]) {
        self.bgColor = bgColor;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        _cornerType = type;
        _radius = radius;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    CGFloat offSetY = (_cornerType == cornerType_no ? 0 : 8);
    
    //path移动到开始画图的位置
    [path moveToPoint:CGPointMake(0, _radius + offSetY)];
    [path addArcWithCenter:CGPointMake(_radius, _radius + offSetY) radius:_radius startAngle:M_PI endAngle: M_PI *1.5 clockwise:YES];
    
    switch (_cornerType) {
        case cornerType_right: {
            // 三角形的三个角
            [path addLineToPoint:CGPointMake(w - 32, offSetY)];
            [path addLineToPoint:CGPointMake(w - 25, 0)];
            [path addLineToPoint:CGPointMake(w - 18, offSetY)];
            break;
        }
        case cornerType_left: {
            // 三角形的三个角
            [path addLineToPoint:CGPointMake(18, offSetY)];
            [path addLineToPoint:CGPointMake(25, 0)];
            [path addLineToPoint:CGPointMake(32, offSetY)];
            break;
        }
        case cornerType_middle: {
            // 三角形的三个角
            CGFloat middle = w * .5f;
            [path addLineToPoint:CGPointMake(middle - 7, offSetY)];
            [path addLineToPoint:CGPointMake(middle, 0)];
            [path addLineToPoint:CGPointMake(middle + 7, offSetY)];
            break;
        }
        case cornerType_bottom: {
            // 三角形的三个角
//            CGFloat middle = w * .5f;
//            [path addLineToPoint:CGPointMake(middle - 7, h - offSetY)];
//            [path addLineToPoint:CGPointMake(w - 25, 0)];
//            [path addLineToPoint:CGPointMake(middle + 7, h - offSetY)];
            break;
        }
        case cornerType_no: {
            break;
        }
        default:
            break;
    }
    
    [path addLineToPoint:CGPointMake(w - _radius, offSetY)];
    [path addArcWithCenter:CGPointMake(w - _radius, _radius + offSetY) radius:_radius startAngle: - M_PI * .5 endAngle: 0 clockwise:YES];
    [path addLineToPoint:CGPointMake(w , h - _radius)];
    [path addArcWithCenter:CGPointMake(w - _radius, h - _radius) radius:_radius startAngle: 0 endAngle: M_PI *.5 clockwise:YES];
    [path addLineToPoint:CGPointMake(_radius , h)];
    [path addArcWithCenter:CGPointMake(_radius, h - _radius) radius:_radius startAngle:M_PI * .5 endAngle: M_PI clockwise:YES];
    
    //关闭path
    [path closePath];
    
    //填充颜色
    [self.bgColor setFill];
    [path fill];
    
}

- (void)dealloc {
    CLog(@"dealloc === %@",[self class]);
}

@end
