//
//  AccountService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AccountService.h"

#import "UserClient.h"
#import "MessageService.h"

#import "LYPushBusinessClass.h"

@interface AccountService ()

@property (nonatomic,strong)UserClient *client;

@property (nonatomic,assign)BOOL isLogin;
@property (nonatomic,strong)UserInfoModel *signInUser;

@end

@implementation AccountService

#pragma mark -单例
+ (instancetype)shareInstance
{
    static AccountService *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:NULL];
        shareInstance.client = [UserClient new];
    });
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [AccountService shareInstance];
}

+ (id)copy
{
    return [AccountService shareInstance];
}

#pragma mark -登录
// 自动登录
- (RACSignal *)autoLogin
{
    UserInfoModel *lastUser = [UserInfoModel searchSingleWithWhere:nil orderBy:@"lastLoginTime desc"];
    if (lastUser.token.length) {
        // 刷新token
        self.signInUser = lastUser;
        @weakify(self);
        return [[self refreshToken] doNext:^(id x) {
            @strongify(self);
            self.isLogin = YES;
            [self loginSuccessCommonAction];
        }];
    }else{
        return [RACSignal error:AppErrorSetting(@"无本地登录信息")];
    }
}
// 手机号+密码
- (RACSignal *)loginByPhoneNumber:(NSString *)phoneNumber
                         passWord:(NSString *)passWord
{
    @weakify(self);
    return [[self.client loginWithMobile:phoneNumber
                                password:passWord
                              login_type:loginTypePassWord
                                 smscode:nil] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        @strongify(self);
        NSString *token = dict[@"data"][@"access_token"];
        if (!token.length) {
            *errorPtr = AppErrorSetting(@"access_token为空");
            return nil;
        }
        // 用户信息存库
        UserInfoModel *user = [UserInfoModel new];
        user.mobilePhone = phoneNumber;
        user.token = token;
        user.lastLoginTime = [NSDate date];
        [user saveToDB];
        // 设置登录状态
        self.signInUser = user;
        self.isLogin = YES;
        [self loginSuccessCommonAction];
        return @(YES);
    }];
}
// 手机号+验证码
- (RACSignal *)loginByPhoneNumber:(NSString *)phoneNumber
                       verifyCode:(NSString *)verifyCode
{
    @weakify(self);
    return [[self.client loginWithMobile:phoneNumber
                                password:nil
                              login_type:loginTypeSms
                                 smscode:verifyCode] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        @strongify(self);
        NSString *token = dict[@"data"][@"access_token"];
        if (!token.length) {
            *errorPtr = AppErrorSetting(@"access_token为空");
            return nil;
        }
        // 用户信息存库
        UserInfoModel *user = [UserInfoModel new];
        user.mobilePhone = phoneNumber;
        user.token = token;
        user.lastLoginTime = [NSDate date];
        [user saveToDB];
        // 设置登录状态
        self.signInUser = user;
        self.isLogin = YES;
        [self loginSuccessCommonAction];
        return @(YES);
    }];
}
// 登录成功后
- (void)loginSuccessCommonAction
{
    @weakify(self);
    // 设置推送绑定
    [JPush setRegistrationID];
    // 获取是否设置过密码
    [[self getIsSetPassword] subscribeNext:^(id x) {
        @strongify(self);
        self.signInUser.isInitPassword = [x boolValue];
    }];
    // 获取全局消息数量
    [[MessageService shareInstance] fetchUnreadMessageCount];
    // 获取购物车数量
    [[ShoppingCartService sharedInstance] getCartGoodsQuantity];
}

// 获取是否设置过密码
- (RACSignal *)getIsSetPassword
{
    return [[self.client getIsSetPassword] map:^id(NSDictionary *dict) {
        if ([dict[@"data"][@"is_set"] integerValue] == 1) {
            return @(YES);
        }
        return @(NO);
    }];
}

#pragma mark -登出
- (void)logOut:(dispatch_block_t)finish
{
    @weakify(self);
    // 取消推送绑定
    [JPush cancelRegistrationID:^{
        @strongify(self);
        // 退出登录接口
        [DLLoading DLLoadingInWindow:nil close:nil];
        [[self.client logOut] subscribeNext:^(id x) {
            @strongify(self);
            [DLLoading DLHideInWindow];
            [self logOutAction];
            if (finish) {
                finish();
            }
        } error:^(NSError *error) {
            @strongify(self);
            [DLLoading DLHideInWindow];
            [self logOutAction];
            if (finish) {
                finish();
            }
        }];
    }];
}
// logOutAction
- (void)logOutAction
{
    [self.signInUser deleteToDB];
    self.signInUser = nil;
    self.isLogin = NO;
    // 清除未读消息数
    [[MessageService shareInstance] clearUnreadMessageCount];
    // 清除购物车商品数量
    [[ShoppingCartService sharedInstance] clearCartGoodsQuantity];
}

#pragma mark -注册
- (RACSignal *)registerWithMobile:(NSString *)mobile
                          smscode:(NSString *)smscode
                    refereemobile:(NSString *)refereemobile
                             type:(NSString *)type
{
    @weakify(self);
    return [[self.client registerWithMobile:mobile
                                    smscode:smscode
                              refereemobile:refereemobile
                                       type:type] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        @strongify(self);
        NSString *token = dict[@"data"][@"access_token"];
        if (!token.length) {
            *errorPtr = AppErrorSetting(@"access_token为空");
            return nil;
        }
        // 用户信息存库
        UserInfoModel *user = [UserInfoModel new];
        user.mobilePhone = mobile;
        user.token = token;
        user.lastLoginTime = [NSDate date];
        [user saveToDB];
        // 设置登录状态
        self.signInUser = user;
        self.isLogin = YES;
        [self loginSuccessCommonAction];
        return @(YES);
    }];
}

#pragma mark -验证码
- (RACSignal *)sendVerifyCodeWithMobile:(NSString *)mobile
                               sms_type:(NSString *)sms_type
{
    return [[self.client sendVerifyCodeWithMobile:mobile
                                        sms_type:sms_type] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -修改密码
- (RACSignal *)reSetPasswordWithOld_password:(NSString *)old_password
                                new_password:(NSString *)new_password
                            confirm_password:(NSString *)confirm_password
{
    return [[self.client reSetPasswordWithOld_password:old_password
                                         new_password:new_password
                                     confirm_password:confirm_password] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -设置密码
- (RACSignal *)setPasswordWithNew_password:(NSString *)new_password
                          confirm_password:(NSString *)confirm_password
{
    return [[self.client setPasswordWithNew_password:new_password
                                   confirm_password:confirm_password] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -刷新token
- (RACSignal *)refreshToken
{
    @weakify(self);
    return [[self.client refreshToken] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        @strongify(self);
        NSString *token = dict[@"data"][@"access_token"];
        if (token.length) {
            self.signInUser.token = token;
            self.signInUser.lastLoginTime = [NSDate date];
            [self.signInUser saveToDB];
            return @(YES);
        }else{
            *errorPtr = AppErrorSetting(@"刷新token失败:token为空");
            return nil;
        }
    }];
}

@end
