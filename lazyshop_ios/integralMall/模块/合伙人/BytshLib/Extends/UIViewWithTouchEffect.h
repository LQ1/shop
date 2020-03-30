//
//  UIViewWithTouchEffect.h
//  NtOA
//
//  Created by liu on 16/4/9.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewWithTouchEffect : UIView{
    UIColor *colorOri;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end

