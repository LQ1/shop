//
//  NSString+Extends.h
//  BytshBase
//
//  Created by liu on 2017/7/7.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Extends)

- (BOOL)isNullOrEmpty;

- (NSString*)getSafeString;

- (int)getSafeInt;

- (NSString*)encodingToUTF8;

- (NSString*)getMd5String;

- (BOOL)isContainString:(NSString*)szSubStr;
//格式化日期
- (NSString*)formateDate:(NSString*)szFormat;

//url解码
- (NSString *)urlDecode;
//url编码
- (NSString *)urlEncode;

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
