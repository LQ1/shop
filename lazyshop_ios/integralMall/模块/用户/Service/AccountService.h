//
//  AccountService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfoModel.h"

@interface AccountService : NSObject

/*
 *  登录状态
 */
@property (nonatomic,readonly)BOOL isLogin;

/*
 *  当前登录用户
 */
@property (nonatomic,readonly)UserInfoModel *signInUser;

/*
 *加入合伙人图
 */
@property (nonatomic,strong)PartnerModel *partner;

/*
 *  单例
 */
+ (instancetype)shareInstance;

/*
 *  自动登录
 */
- (RACSignal *)autoLogin;

/*
 *  手机号+密码 登录
 */
- (RACSignal *)loginByPhoneNumber:(NSString *)phoneNumber
                         passWord:(NSString *)passWord;
/*
 *  手机号+验证码 登录
 */
- (RACSignal *)loginByPhoneNumber:(NSString *)phoneNumber
                       verifyCode:(NSString *)verifyCode;

/*
 *  登出
 */
- (void)logOut:(dispatch_block_t)finish;

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

#pragma mark -修改密码
- (RACSignal *)reSetPasswordWithOld_password:(NSString *)old_password
                                new_password:(NSString *)new_password
                            confirm_password:(NSString *)confirm_password;

#pragma mark -设置密码
- (RACSignal *)setPasswordWithNew_password:(NSString *)new_password
                          confirm_password:(NSString *)confirm_password;

#pragma mark -刷新token
- (RACSignal *)refreshToken;

@end
