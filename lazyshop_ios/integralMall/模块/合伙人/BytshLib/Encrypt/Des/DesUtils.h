//
//  DesUtils.h
//  SecurityMgr
//
//  Created by liu on 2018/2/28.
//  Copyright © 2018年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Extend.h"
#import "GTMBase64.h"

@interface DesUtils : NSObject

+ (NSString*)getDesKey;

+(NSString *) encryptUseDES:(NSString *)plainText;
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

+(NSString *)decryptUseDES:(NSString *)cipherText;
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
