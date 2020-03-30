//
//  LoginByPasswordViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface LoginByPasswordViewModel : LoginBaseViewModel

@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *password;

@property (nonatomic,assign) BOOL isPhoneNumberTrue;

/*
 *  登录按钮是否可用
 */
- (RACSignal *)loginButtonValidSignal;

/*
 *  开始登录
 */
- (void)login;

@end
