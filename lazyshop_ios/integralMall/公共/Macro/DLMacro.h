//
//  DLMacro.h
//  DL
//
//  Created by cyx on 14-9-16.
//  Copyright (c) 2014年 Cdeledu. All rights reserved.
//

#ifndef DL_DLMacro_h
#define DL_DLMacro_h

#import <SDWebImage/UIImageView+WebCache.h>
#import <JSONKit-NoWarning/JSONKit.h>
#import <MD5Digest/NSString+MD5.h>

#import <DLUtls/CommUtls.h>
#import <DLUtls/NetStatusHelper.h>
#import <BaseWithRAC/BaseMacro.h>
#import <DLUIKit/DLAlertShowAnimate.h>
#import <CommUtls+Time.h>

#import "LYHttpHelper.h"
#import "UIImageView+LYLogCache.h"
#import "UIView+AddSub.h"
#import "UIView+Separator.h"
#import "UIView+Loading.h"
#import "NSObject+GetStringValue.h"
#import "LYAlertView.h"

#import "PublicEventManager.h"
#import "AccountService.h"
#import "LoginCommonManager.h"
#import "ShoppingCartService.h"
#import "LazyShopEnumMacro.h"
#import "LYAppCheckManager.h"

#define LYAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define AppErrorMsgKey              @"errorInfo"
#define AppErrorMsg                 @"网络可能开小差了"
#define AppNetErrorMsg              @"数据错误"

// 分页
#define PageGetDataNumber           10

// 用户
#define loginTypePassWord   @"password"
#define loginTypeSms        @"sms"
#define smsTypeLogin        @"login"
#define smsTypeRegister     @"register"
#define smsTypeFindPassword @"find_password"

// 微信appID
#define WX_APP_ID           @"wx41d416a706a0cd32"

// 支付宝scheme
#define ALI_PAY_SCHEME      @"alipaylazyshop"

// 银联scheme
#define UNION_PAY_SCHEME    @"unionpaylazyshop"

// 极光推送key
#define J_PUSH_KEY          @"1b9251267c6a70c258b845c9"

// 友盟统计key
#define UMENG_KEY           @"59e2371745297d211a00004d"

// 平台号
#define PLATFORM_VALUE      2

// 错误解析
#define AppErrorParsing(__error)    \
({  \
NSString *title = nil;   \
if ([__error isKindOfClass:[NSError class]]) {  \
if ([__error.domain isEqualToString:CustomErrorDomain]) {     \
title = __error.userInfo[AppErrorMsgKey];   \
}   \
if(!title.length){  \
if(__error.code == DLNoNet && __error.userInfo[NSLocalizedDescriptionKey]) {  \
title = NO_NET_STATIC_SHOW;    \
}   \
}   \
}   \
if(!title.length){  \
title = AppErrorMsg;    \
}   \
title;  \
})

// 空数据错误设置
#define AppErrorEmptySetting(__errorName)    \
({  \
NSString *title = AppErrorMsg;   \
if(__errorName){\
title = __errorName;\
}\
[NSError errorWithDomain:CustomErrorDomain code:DLDataEmpty userInfo:@{AppErrorMsgKey:title}];\
})

// 错误设置
#define AppErrorSetting(__errorName)    \
({  \
NSString *title = AppErrorMsg;   \
if(__errorName){\
title = __errorName;\
}\
[NSError errorWithDomain:CustomErrorDomain code:DLDataFailed userInfo:@{AppErrorMsgKey:title}];\
})

// 未付费用户默认UID
#define NO_PAY_UID   -1

// 单例
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

// 当前登录用户
#define SignInUser [AccountService shareInstance].signInUser
#define SignInToken [AccountService shareInstance].signInUser.token


#endif
