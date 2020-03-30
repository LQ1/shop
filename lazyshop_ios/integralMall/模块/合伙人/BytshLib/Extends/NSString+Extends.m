//
//  NSString+Extends.m
//  BytshBase
//
//  Created by liu on 2017/7/7.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "NSString+Extends.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Extends)

- (BOOL)isNullOrEmpty{
    return [self isKindOfClass:[NSNull class]] || self == nil || [self isEqualToString:@""];
}

- (NSString*)getSafeString{
    if ([self isNullOrEmpty]) {
        return @"";
    }
    return self;
}

- (int)getSafeInt{
    if ([self isKindOfClass:[NSString class]]) {
        return [self intValue];
    }
    return 0;
}

//格式化日期
- (NSString*)formateDate:(NSString*)szFormat{
    NSDateFormatter *ndf = [[NSDateFormatter alloc] init];
    [ndf setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt = [ndf dateFromString:self];
    if (dt) {
        [ndf setDateFormat:szFormat];
        return [ndf stringFromDate:dt];
    }
    return @"";
}

- (NSString*)encodingToUTF8{
    NSString *szUTF8 = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, NULL, kCFStringEncodingUTF8));
    return szUTF8;
}

- (NSString*)getMd5String{
    const char *str = [self UTF8String];
    unsigned char result[16];
    CC_MD5(str,(unsigned int)strlen(str),result);
    NSMutableString *szRet = [NSMutableString stringWithCapacity:32];
    for (int i=0; i<16; i++) {
        [szRet appendFormat:@"%02X",result[i]];
    }
    return szRet;
}

- (BOOL)isContainString:(NSString*)szSubStr{
    if (self && szSubStr) {
        NSRange range = [self rangeOfString:szSubStr options:NSCaseInsensitiveSearch];
        if (range.length >0) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)urlDecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncode
{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
