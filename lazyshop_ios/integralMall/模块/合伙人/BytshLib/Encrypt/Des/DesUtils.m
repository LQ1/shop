//
//  DesUtils.m
//  SecurityMgr
//
//  Created by liu on 2018/2/28.
//  Copyright © 2018年 liu. All rights reserved.
//

#import "DesUtils.h"
#import <CommonCrypto/CommonCryptor.h>
#import "AppDelegate.h"

@implementation DesUtils

//key 密钥只能是8个字符64位如果位数不足的话，会自动补别的东西。每次不同。。。
+ (NSString*)getDesKey{
    return @"12345678";
}

+(NSString *) encryptUseDES:(NSString *)plainText{
    return [self encryptUseDES:plainText key:[self getDesKey]];
}
//加密
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    size_t dataLength = [plainText length];
    //==================
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, [key UTF8String], kCCKeySizeDES, iv, textBytes, dataLength, (void *)bufferPtr, bufferPtrSize, &movedBytes);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:bufferPtr length:movedBytes];
        ciphertext = [data hexString];
    }
    ciphertext=[ciphertext uppercaseString];//字符变大写
    return ciphertext ;
}

+(NSString *)decryptUseDES:(NSString *)cipherText{
    return [self decryptUseDES:cipherText key:[self getDesKey]];
}
//解密
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key {
    NSData* cipherData = [NSData dataWithHexString:cipherText];
    NSLog(@"++++++++///%@",cipherData);
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, [key UTF8String], kCCKeySizeDES, iv, [cipherData bytes], [cipherData length], buffer, 1024, &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}










@end
