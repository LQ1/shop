//
//  FindPasswordViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FindPasswordViewModel.h"

#import "LoginPhoneAndVerifyCodeInputViewModel.h"

#import "SetPasswordViewModel.h"

@interface FindPasswordViewModel ()

@property (nonatomic,strong ) LoginPhoneAndVerifyCodeInputViewModel *phoneAndVerifyCodeInputViewModel;

@end

@implementation FindPasswordViewModel

#pragma mark -初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.phoneAndVerifyCodeInputViewModel = [[LoginPhoneAndVerifyCodeInputViewModel alloc] initSmsType:smsTypeFindPassword];
    }
    return self;
}

#pragma mark -下一步按钮是否可用
- (RACSignal *)nextButtonValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self.phoneAndVerifyCodeInputViewModel,phoneNumber),RACObserve(self.phoneAndVerifyCodeInputViewModel, verifyCode)]
                             reduce:^id(NSString *value1, NSString *value2){
                                 return @(value1.length > 0 && value2.length > 0);
                             }];
}

#pragma mark -获取VM
- (id)fetchPhoneAndVerifyCodeInputViewModel
{
    return  self.phoneAndVerifyCodeInputViewModel;
}

#pragma mark -下一步
- (void)nextClick
{
    // 手机号格式
    if (!self.phoneAndVerifyCodeInputViewModel.isPhoneNumberTrue) {
        [self.tipLoadingSignal sendNext:@"请输入正确的手机号"];
        return;
    }
    // 验证码是否正确
    if (![self.phoneAndVerifyCodeInputViewModel isInputVerifyCodeCorrect]) {
        [self.tipLoadingSignal sendNext:@"验证码错误"];
        return;
    }
    // 先用验证码登录 登录成功后设置密码
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service loginByPhoneNumber:self.phoneAndVerifyCodeInputViewModel.phoneNumber
                                                   verifyCode:self.phoneAndVerifyCodeInputViewModel.verifyCode] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        // 进入设置密码界面
        SetPasswordViewModel *setPwdVM = [[SetPasswordViewModel alloc] initWithPhoneNumber:self.phoneAndVerifyCodeInputViewModel.phoneNumber];
        [self.updatedContentSignal sendNext:setPwdVM];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
