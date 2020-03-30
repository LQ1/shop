//
//  NSData+Extend.h
//  SecurityMgr
//
//  Created by liu on 2018/3/1.
//  Copyright © 2018年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extend)

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

@end
