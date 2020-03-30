//
//  UIScrollView+CancelInsetBehavior.h
//  NetSchool
//
//  Created by LiYang on 2017/11/14.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CancelInsetBehavior)

/*
 * 之前设置vc的automaticallyAdjustsScrollViewInsets iOS11以后需要设置UIScrollView的此方法
 */
- (void)cancelInsetAdjustmentBehavior;

@end
