//
//  DLShareConstant.h
//  DLShareSDK
//
//  Created by LY on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#ifndef DLShareConstant_h
#define DLShareConstant_h

// 模拟器下不能导入分享sdk
#if TARGET_IPHONE_SIMULATOR

#else

#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#endif

// masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>

// 当前分享类型
typedef enum ShareType{
    ShareTypeQQ         =  3,
    ShareTypeWeixin     = 5
}ShareType;

// 未安装提示标识
#define QQ_ALERT      100
#define WEI_XIN_ALERT 200

//// ios7.1.1下分享skd有问题 屏蔽
//#define ISIOS7_1_1 [[[UIDevice currentDevice] systemVersion] isEqualToString:@"7.1.1"]

#endif /* DLShareConstant_h */
