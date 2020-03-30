//
//  SetPasswordViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SetPasswordViewModel.h"

#import "AccountService.h"

@interface SetPasswordViewModel()

@property (nonatomic,copy)NSString *phoneNumber;

@end

@implementation SetPasswordViewModel

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self) {
        self.phoneNumber = phoneNumber;
    }
    return self;
}

#pragma mark -确认按钮是否可用
- (RACSignal *)submitButtonValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self,password),RACObserve(self, confirmPassword)]
                             reduce:^id(NSString *value1, NSString *value2){
                                 return @(value1.length > 0 && value2.length > 0);
                             }];
}

#pragma mark -开始提交
- (void)submit
{
    // 密码格式
    if (!self.isPasswordTrue) {
        [self.tipLoadingSignal sendNext:@"请输入6-16位数字字母密码"];
        return;
    }
    // 两次密码是否一致
    if (![self.password isEqualToString:self.confirmPassword]) {
        [self.tipLoadingSignal sendNext:@"两次密码输入不一致"];
        return;
    }
    // 请求设置密码接口
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service setPasswordWithNew_password:self.password
                                                      confirm_password:self.confirmPassword] subscribeNext:^(id x) {
        @strongify(self);
        // 设置密码成功
        self.service.signInUser.isInitPassword = YES;
        self.loading = NO;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
