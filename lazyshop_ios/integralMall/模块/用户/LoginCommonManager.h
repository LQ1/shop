//
//  LoginCommonManager.h
//  NetSchool
//
//  Created by LY on 2017/4/17.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginCommonManager : NSObject

/**
 *  登录成功信号
 */
@property (nonatomic,readonly)RACSubject *loginSuccessSignal;

/**
 *  单例
 */
+ (LoginCommonManager *)sharedInstance;

/**
 *  pop登录前界面
 */
- (void)popToFrontOfLoginViewControllerWithNavigationController:(UINavigationController *)navigationController;

@end
