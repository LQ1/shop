//
//  UserClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserClient : NSObject

/*
 *  登录
 */
- (RACSignal *)loginWithMobile:(NSString *)mobile
                      password:(NSString *)password
                    login_type:(NSString *)login_type
                       smscode:(NSString *)smscode;
/*
 *  注册
 */
- (RACSignal *)registerWithMobile:(NSString *)mobile
                          smscode:(NSString *)smscode
                    refereemobile:(NSString *)refereemobile
                             type:(NSString *)type;

/*
 *  验证码
 */
- (RACSignal *)sendVerifyCodeWithMobile:(NSString *)mobile
                               sms_type:(NSString *)sms_type;

/*
 *  是否设置过密码
 */
- (RACSignal *)getIsSetPassword;

#pragma mark -修改密码
- (RACSignal *)reSetPasswordWithOld_password:(NSString *)old_password
                                new_password:(NSString *)new_password
                            confirm_password:(NSString *)confirm_password;

#pragma mark -设置密码
- (RACSignal *)setPasswordWithNew_password:(NSString *)new_password
                          confirm_password:(NSString *)confirm_password;

#pragma mark -刷新token
- (RACSignal *)refreshToken;

#pragma mark -退出登录
- (RACSignal *)logOut;

@end
