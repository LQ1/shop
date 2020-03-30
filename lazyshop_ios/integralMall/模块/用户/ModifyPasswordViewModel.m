//
//  ModifyPasswordViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ModifyPasswordViewModel.h"

#import "AccountService.h"

@interface ModifyPasswordViewModel()

@end

@implementation ModifyPasswordViewModel

#pragma mark -确认按钮是否可用
- (RACSignal *)submitButtonValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self,oldPassword),RACObserve(self, nPassword),RACObserve(self, nConfirmPassword)]
                             reduce:^id(NSString *value1, NSString *value2 , NSString *value3){
                                 return @(value1.length > 0 && value2.length > 0 && value3.length > 0);
                             }];
}

#pragma mark -开始提交
- (void)submit
{
    // 密码格式
    if (!self.isNewPasswordTrue) {
        [self.tipLoadingSignal sendNext:@"新密码格式不正确"];
        return;
    }
    // 两次密码是否一致
    if (![self.nPassword isEqualToString:self.nConfirmPassword]) {
        [self.tipLoadingSignal sendNext:@"两次新密码输入不一致"];
        return;
    }
    // 请求设置密码接口
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service reSetPasswordWithOld_password:self.oldPassword
                                                            new_password:self.nPassword
                                                        confirm_password:self.nConfirmPassword] subscribeNext:^(id x) {
        @strongify(self);
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
