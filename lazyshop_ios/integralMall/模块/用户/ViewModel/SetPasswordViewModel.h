//
//  SetPasswordViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface SetPasswordViewModel : LoginBaseViewModel

@property (nonatomic,readonly)NSString *phoneNumber;

@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *confirmPassword;

@property (nonatomic,assign) BOOL isPasswordTrue;

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber;

/*
 *  确认按钮是否可用
 */
- (RACSignal *)submitButtonValidSignal;

/*
 *  开始提交
 */
- (void)submit;

@end
