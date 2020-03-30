//
//  LoginBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface LoginBaseViewModel : BaseViewModel

@property (nonatomic,readonly) AccountService *service;

/**
 *  弹框信号
 */
@property (nonatomic,readonly)RACSubject *tipLoadingSignal;
/**
 *  登录成功信号
 */
@property (nonatomic,readonly)RACSubject *loginSuccessSignal;

@end
