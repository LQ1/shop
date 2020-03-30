//
//  GlobalSetting.h
//  NtOA
//
//  Created by liu on 16/4/9.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GlobalSetting : NSObject

+ (GlobalSetting*)getThis;

//滚动通知的内容
@property NSMutableArray *arrayPartnerScrollInfos;

@property NSString *NET_IMAGE_PREFIX;

//用户更改后的头像
@property UIImage *imgHeader;

@property NSString *szServerHost;

@end
