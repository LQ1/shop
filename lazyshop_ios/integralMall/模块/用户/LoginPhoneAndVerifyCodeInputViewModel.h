//
//  LoginPhoneAndVerifyCodeInputViewModel.h
//  NetSchool
//
//  Created by LY on 2017/4/11.
//  Copyright © 2017年 CDEL. All rights reserved.
//



#import <BaseWithRAC/BaseViewModel.h>

//typedef NS_ENUM(NSInteger, LoginPhoneAndVerifyCodeInputViewModel_Signal_Type) {
//    Signal_Type_ = 0,
//};

@interface LoginPhoneAndVerifyCodeInputViewModel : BaseViewModel

// 手机号
@property (nonatomic,copy       ) NSString   *phoneNumber;
// 验证码
@property (nonatomic,copy       ) NSString   *verifyCode;

// 手机号格式是否正确
@property (nonatomic,assign     ) BOOL       isPhoneNumberTrue;

// 验证码剩余秒数
@property (nonatomic, readonly  ) NSInteger  remainingSec;

// 获取验证码成功信号
@property (nonatomic,readonly   ) RACSubject *fetchVerifyCodeSuccessSignal;
// 获取验证码失败信号
@property (nonatomic,readonly   ) RACSubject *fetchVerifyCodeErrorSignal;

/**
 *  初始化
 *
 *  @param smsType 验证码类型
 *
 *  @return <#return value description#>
 */
- (instancetype)initSmsType:(NSString *)smsType;

/**
 *  获取验证码按钮是否可用
 *
 *  @return <#return value description#>
 */
- (RACSignal *)codeValidSignal;

/**
 *  获取验证码
 */
- (void)fetchVerifyCode;

/**
 *  验证码输入是否正确
 */
- (BOOL)isInputVerifyCodeCorrect;

@end
