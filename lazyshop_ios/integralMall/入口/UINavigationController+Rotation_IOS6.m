//
//  UINavigationController+Rotation_IOS6.m
//  RDOpenClass
//
//  Created by cyx on 13-1-10.
//  Copyright (c) 2013年 cyx. All rights reserved.
//

#import "UINavigationController+Rotation_IOS6.h"

@implementation UINavigationController (Rotation_IOS6)

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

// 返回最上层的子Controller的supportedInterfaceOrientations
- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
