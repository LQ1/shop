//
//  RegisterViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RegisterViewModel.h"

#import "LoginPhoneAndVerifyCodeInputViewModel.h"

@interface RegisterViewModel ()

@property (nonatomic,strong ) LoginPhoneAndVerifyCodeInputViewModel *phoneAndVerifyCodeInputViewModel;

@end

@implementation RegisterViewModel

#pragma mark -初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.phoneAndVerifyCodeInputViewModel = [[LoginPhoneAndVerifyCodeInputViewModel alloc] initSmsType:smsTypeRegister];
    }
    return self;
}

#pragma mark -注册按钮是否可用
- (RACSignal *)registerButtonValidSignal
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

#pragma mark -注册
- (void)registerClick
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
    // 请求注册接口
    self.loading = YES;
    @weakify(self);
    RACDisposable *disPos = [[self.service registerWithMobile:self.phoneAndVerifyCodeInputViewModel.phoneNumber
                                                      smscode:self.phoneAndVerifyCodeInputViewModel.verifyCode
                                                refereemobile:self.recommenderPhone
                                                         type:[NSString stringWithFormat:@"%ld",(long)self.recommederType]] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.loginSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
