//
//  ModifyPasswordViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface ModifyPasswordViewModel : LoginBaseViewModel

@property (nonatomic,copy)NSString *oldPassword;
@property (nonatomic,copy)NSString *nPassword;
@property (nonatomic,copy)NSString *nConfirmPassword;

@property (nonatomic,assign) BOOL isNewPasswordTrue;

/*
 *  确认按钮是否可用
 */
- (RACSignal *)submitButtonValidSignal;

/*
 *  开始提交
 */
- (void)submit;

@end
