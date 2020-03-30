//
//  CountDownView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CountDownViewHeight 15

@interface LYCountDownView : UIView

- (instancetype)initWithItemBackColorString:(NSString *)backColorString
                            textColorString:(NSString *)textColorString
                             dotColorString:(NSString *)dotColorString
                                   dotWidth:(CGFloat)dotWidth;

- (CGFloat)totalWidth;

- (void)setRemainingTime:(NSInteger)time;

@end
