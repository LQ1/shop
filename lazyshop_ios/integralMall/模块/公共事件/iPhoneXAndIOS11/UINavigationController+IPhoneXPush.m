//
//  UINavigationController+IPhoneXPush.m
//  NetSchool
//
//  Created by LiYang on 2017/11/16.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "UINavigationController+IPhoneXPush.h"

@implementation UINavigationController (IPhoneXPush)

+ (void)load
{
    [super load];
    if (iPhoneX) {
        Method fromMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
        Method toMethod = class_getInstanceMethod(self, @selector(iphoneX_pushViewController:animated:));
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (void)iphoneX_pushViewController:(UIViewController *)viewController
                          animated:(BOOL)animated
{
    [self iphoneX_pushViewController:viewController animated:animated];
    // 解决iPhoneX push页面时tabbar上移问题
    if (iPhoneX) {
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}

@end
