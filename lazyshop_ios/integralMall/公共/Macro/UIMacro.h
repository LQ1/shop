//
//  UIMacro.h
//  MobileClassPhone
//
//  Created by cyx on 14/12/2.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#ifndef MobileClassPhone_UIMacro_h
#define MobileClassPhone_UIMacro_h

// 字号
#define MAX_LARGE_FONT_SIZE     18
#define LARGE_FONT_SIZE         16
#define MIDDLE_FONT_SIZE        14
#define SMALL_FONT_SIZE         12
#define MIN_FONT_SIZE           10

#define NAVIGATIONBAR_HEIGHT (iPhoneX ? 89 : 65)

#define STATUS_BAR_HEIGHT   (iPhoneX ? 44 : 20)

#define TABLE_BAR_HEIGHT   (iPhoneX ? 83 : 49)

#define HOME_BAR_HEIGHT   (iPhoneX ? 34 : 0)

// 屏幕宽高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

// 小宽度
#define PhoneSmallWidth ([UIScreen mainScreen].bounds.size.width==320)

// 客服电话
#define ServicePhone @"400-159-8288"

// 色值
#define APP_MainColor               @"#E4393C"
#define APP_GapColor                @"#f0f0f0"
#define App_TxtBColor               @"#333333"

// 异常提示
#define LOAD_FAILED_RETRY           @"重试"
#define LOAD_FAILED_SHOW            @"加载失败"
#define ERROR_NORMAL_SHOW           @"网络异常"
#define NO_NET_STATIC_SHOW          @"无网络"
#define NO_NET_TEXT                 @"当前操作需要连接网络"
#define USER_SID_INVALID            @"登录失效，请点击重试"

#endif
