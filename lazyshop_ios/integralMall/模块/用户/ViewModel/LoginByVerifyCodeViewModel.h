//
//  LoginByVerifyCodeViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface LoginByVerifyCodeViewModel : LoginBaseViewModel

/*
 *  登录按钮是否可用
 */
- (RACSignal *)loginButtonValidSignal;

/*
 *  获取VM
 */
- (id)fetchPhoneAndVerifyCodeInputViewModel;

/*
 *  开始登录
 */
- (void)login;

@end
