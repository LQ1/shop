//
//  UIViewWithTouchEffect.m
//  NtOA
//
//  Created by liu on 16/4/9.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//

#import "UIViewWithTouchEffect.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation UIViewWithTouchEffect

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    colorOri = self.backgroundColor;
    [self setBackgroundColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0]];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    //[self setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    //[self setBackgroundColor:colorOri];
    [self performSelector:@selector(delaySetBackgroundColor) withObject:nil afterDelay:0.1];
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    //[self setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [self setBackgroundColor:colorOri];
}

- (void)delaySetBackgroundColor{
    [self setBackgroundColor:colorOri];
}

@end

