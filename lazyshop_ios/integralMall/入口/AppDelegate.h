//
//  AppDelegate.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassTableBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic)UINavigationController *pushNavigationController;
@property (strong  , nonatomic)ClassTableBarViewController *tabBarController;

@end

