//
//  LoginPhoneAndVerifyCodeInputView.h
//  NetSchool
//
//  Created by LY on 2017/4/11.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginPhoneAndVerifyCodeInputViewModel;

#define LoginPhoneAndVerifyCodeHeight 100

@interface LoginPhoneAndVerifyCodeInputView : UIView

/**
 *  初始化
 */
- (instancetype)initWithPhonePlaceHolder:(NSString *)phonePlaceHolder
                   verifyCodePlaceHolder:(NSString *)verifyCodePlaceHolder;

/**
 *  绑定ViewModel
 */
- (void)bindViewModel:(LoginPhoneAndVerifyCodeInputViewModel *)viewModel;

/**
 *  结束编辑
 */
- (void)endEditting;

@end
