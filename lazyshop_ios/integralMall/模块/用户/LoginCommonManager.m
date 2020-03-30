//
//  LoginCommonManager.m
//  NetSchool
//
//  Created by LY on 2017/4/17.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginCommonManager.h"

#import "LoginByPasswordViewController.h"

@implementation LoginCommonManager

#pragma mark - 单例

static LoginCommonManager *loginCommonInstance = nil;

+ (LoginCommonManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginCommonInstance                      = [[super allocWithZone:NULL] init];
        loginCommonInstance->_loginSuccessSignal = [[RACSubject subject] setNameWithFormat:@"%@ loginSuccessSignal", self.class];
    });
    
    return loginCommonInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [LoginCommonManager sharedInstance];
}

+ (id)copy
{
    return [LoginCommonManager sharedInstance];
}

#pragma mark -跳转到登录前界面
- (void)popToFrontOfLoginViewControllerWithNavigationController:(UINavigationController *)navigationController
{
    // 发送登录成功信号
    [self.loginSuccessSignal sendNext:nil];
    // 视图pop
    __block NSUInteger popIndex = 0;
    [navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LoginByPasswordViewController class]]) {
            *stop = YES;
            if (idx>0) {
                popIndex = idx - 1;
            }else{
                popIndex = idx;
            }
        }
    }];
    
    [navigationController popToViewController:[navigationController.viewControllers objectAtIndex:popIndex] animated:YES];
}

@end
