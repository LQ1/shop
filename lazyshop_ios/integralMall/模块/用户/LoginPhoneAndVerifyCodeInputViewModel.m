//
//  LoginPhoneAndVerifyCodeInputViewModel.m
//  NetSchool
//
//  Created by LY on 2017/4/11.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginPhoneAndVerifyCodeInputViewModel.h"

#import <MD5Digest/NSString+MD5.h>

#import "AccountService.h"

@interface LoginPhoneAndVerifyCodeInputViewModel ()

@property (nonatomic,strong ) AccountService *service;

// 验证码类型
@property (nonatomic, copy) NSString           *sms_type;

// 是否验证码正在倒计时
@property (nonatomic, assign) BOOL           isRemaining;
// 验证码剩余秒数
@property (nonatomic, assign) NSInteger      remainingSec;

// 获取验证码时的手机号
@property (nonatomic, copy  ) NSString       *lastSendedPhoneNumber;
// 服务器返回的验证码
@property (nonatomic, copy  ) NSString       *netBackVerifyCode;

@end

@implementation LoginPhoneAndVerifyCodeInputViewModel

#pragma mark -初始化
- (instancetype)initSmsType:(NSString *)smsType
{
    self = [super init];
    if (self) {
        self.sms_type                 = smsType;
        self.service                  = [AccountService shareInstance];
        _fetchVerifyCodeSuccessSignal = [[RACSubject subject] setNameWithFormat:@"%@ fetchVerifyCodeSuccessSignal", self.class];
        _fetchVerifyCodeErrorSignal   = [[RACSubject subject] setNameWithFormat:@"%@ fetchVerifyCodeErrorSignal", self.class];
    }
    return self;
}

#pragma mark -验证码相关
// 获取验证码按钮是否可用
- (RACSignal *)codeValidSignal
{
    return [RACObserve(self, isRemaining) map:^id (id value) {
        return @(![value boolValue]);
    }];
}
// 获取验证码
- (void)fetchVerifyCode
{
    self.loading = YES;
    @weakify(self);
    // 请求接口
    self.lastSendedPhoneNumber = self.phoneNumber;
    RACSignal *fetchVerifyCodeSignal = [self.service sendVerifyCodeWithMobile:self.phoneNumber
                                                                     sms_type:self.sms_type];
    RACDisposable *disPos = [fetchVerifyCodeSignal subscribeNext:^(id x) {
        @strongify(self);
        [self startCodeTimer];
        self.netBackVerifyCode = x;
        self.loading = NO;
        [self.fetchVerifyCodeSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.remainingSec = 0;
        self.loading = NO;
        [self.fetchVerifyCodeErrorSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 验证码倒计时
- (void)startCodeTimer
{
    self.isRemaining = YES;
    self.remainingSec = 60;
    @weakify(self);
    [[[[RACSignal interval:1. onScheduler:[RACScheduler mainThreadScheduler]] startWith:[NSDate date]]
      takeUntilBlock:^BOOL (id x) {
          @strongify(self);
          return self.remainingSec == 0;
      }] subscribeNext:^(id x) {
          @strongify(self);
          self.remainingSec--;
      } completed:^{
          @strongify(self);
          self.isRemaining = NO;
      }];
}
// 校验验证码输入是否正确
- (BOOL)isInputVerifyCodeCorrect
{
//    // 比对
//    if ([self.lastSendedPhoneNumber isEqualToString:self.phoneNumber] && [self.netBackVerifyCode isEqualToString:self.verifyCode]) {
//        return YES;
//    }
//    return NO;
    return YES;
}

@end
