//
//  UIScrollView+CancelInsetBehavior.m
//  NetSchool
//
//  Created by LiYang on 2017/11/14.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "UIScrollView+CancelInsetBehavior.h"

@implementation UIScrollView (CancelInsetBehavior)

- (void)cancelInsetAdjustmentBehavior
{
#ifdef __IPHONE_11_0
    if (IsIOS11) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}

@end
