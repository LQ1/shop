//
//  LoginByPasswordViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginByPasswordViewModel.h"

@implementation LoginByPasswordViewModel

#pragma mark -登录按钮是否可用
- (RACSignal *)loginButtonValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self,phoneNumber),RACObserve(self, password)]
                             reduce:^id(NSString *value1, NSString *value2){
                                 return @(value1.length > 0 && value2.length > 0);
                             }];
}

#pragma mark -开始登录
- (void)login
{
    // 手机号格式
    if (!self.isPhoneNumberTrue) {
        [self.tipLoadingSignal sendNext:@"请输入正确的手机号"];
        return;
    }
    @weakify(self);
    self.loading = YES;
    RACDisposable *dispos =  [[self.service loginByPhoneNumber:self.phoneNumber
                            passWord:self.password] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.loginSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:dispos];
}

@end
