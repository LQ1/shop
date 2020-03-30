//
//  UserClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "UserClient.h"

#define API_GET_LOGIN       @"http://"APP_DOMAIN@"/auth/login"
#define API_GET_REGISTER    @"http://"APP_DOMAIN@"/auth/register"
#define API_GET_VERIFY_CODE @"http://"APP_DOMAIN@"/sms/send"
#define API_GET_ISSET_PWD   @"http://"APP_DOMAIN@"/user/issetpassword"
#define API_GET_RESET_PWD   @"http://"APP_DOMAIN@"/user/resetpassword"
#define API_GET_SET_PWD     @"http://"APP_DOMAIN@"/user/setpassword"
#define API_REFRESH_TOKEN   @"http://"APP_DOMAIN@"/auth/refresh"
#define API_REFRESH_TOKEN   @"http://"APP_DOMAIN@"/auth/refresh"
#define API_LOGOUT          @"http://"APP_DOMAIN@"/auth/logout"
@implementation UserClient

#pragma mark -登录
- (RACSignal *)loginWithMobile:(NSString *)mobile
                      password:(NSString *)password
                    login_type:(NSString *)login_type
                       smscode:(NSString *)smscode
{
    password = password?:@"";
    mobile = mobile?:@"";
    login_type = login_type?:@"";
    smscode = smscode?:@"";

    NSDictionary *prams = @{
                            @"mobile":mobile,
                            @"password":password,
                            @"login_type":login_type,
                            @"smscode":smscode
                            };
    
    return [LYHttpHelper POST:API_GET_LOGIN params:prams dealCode:YES];
}

#pragma mark -注册
- (RACSignal *)registerWithMobile:(NSString *)mobile
                          smscode:(NSString *)smscode
                    refereemobile:(NSString *)refereemobile
                             type:(NSString *)type
{
    mobile = mobile?:@"";
    smscode = smscode?:@"";
    refereemobile = refereemobile?:@"";
    type = type?:@"";

    NSDictionary *prams = @{
                            @"mobile":mobile,
                            @"smscode":smscode,
                            @"refereemobile":refereemobile,
                            @"type":type
                            };
    
    return [LYHttpHelper POST:API_GET_REGISTER params:prams dealCode:YES];
}

#pragma mark -验证码
- (RACSignal *)sendVerifyCodeWithMobile:(NSString *)mobile
                               sms_type:(NSString *)sms_type
{
    mobile = mobile?:@"";
    sms_type = sms_type?:@"";
    
    NSDictionary *prams = @{
                            @"mobile":mobile,
                            @"sms_type":sms_type
                            };
    
    return [LYHttpHelper POST:API_GET_VERIFY_CODE params:prams dealCode:YES];
}

#pragma mark -是否设置过密码
- (RACSignal *)getIsSetPassword
{
    
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_GET_ISSET_PWD params:prams dealCode:YES];
}

#pragma mark -修改密码
- (RACSignal *)reSetPasswordWithOld_password:(NSString *)old_password
                                new_password:(NSString *)new_password
                            confirm_password:(NSString *)confirm_password
{
    
    NSDictionary *prams = @{
                            @"token":SignInToken,
                            @"old_password":old_password,
                            @"new_password":new_password,
                            @"confirm_password":confirm_password
                            };
    
    return [LYHttpHelper POST:API_GET_RESET_PWD params:prams dealCode:YES];
}

#pragma mark -设置密码
- (RACSignal *)setPasswordWithNew_password:(NSString *)new_password
                          confirm_password:(NSString *)confirm_password
{
    NSString *token = SignInToken?:@"";
    
    NSDictionary *prams = @{
                            @"token":token,
                            @"new_password":new_password,
                            @"confirm_password":confirm_password
                            };
    
    return [LYHttpHelper POST:API_GET_SET_PWD params:prams dealCode:YES];
}

#pragma mark -刷新token
- (RACSignal *)refreshToken
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_REFRESH_TOKEN params:prams dealCode:YES];
}

#pragma mark -退出登录
- (RACSignal *)logOut
{
    NSDictionary *prams = @{
                            @"token":SignInToken
                            };
    
    return [LYHttpHelper POST:API_LOGOUT params:prams dealCode:YES];
}


@end
