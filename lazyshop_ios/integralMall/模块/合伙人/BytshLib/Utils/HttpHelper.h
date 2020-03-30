//
//  HttpHelper.h
//  GovGenoffice
//
//  Created by xtkj on 15/4/27.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"
#import "URLMacro.h"

@interface HttpHelper : NSObject{
    
}
-(id)init;

@property(strong,nonatomic)id progress;


/////////////网络相关/////////////////////////////
+ (NSString*)getPerfixUrl;
+ (NSString*)getRemoteMethodInvoke;
+ (NSString*)getUrl:(NSString*)szURL;
+ (NSData*)sendPostRequest:(NSString*)szURL;
+ (NSData*)sendPostRequest:(NSString*)szURL withParam:(NSDictionary*)param withError:(NSError **)error;
+ (NSData*)sendGetRequest:(NSString *)szURL withParam:(NSDictionary *)param withError:(NSError *__autoreleasing *)error;
+ (NSURL*)getPostFileURL:(NSString*)szFileFullPath withParam:(NSDictionary*)param;;
+ (NSData*)sendPostFileRequest:(NSString*)szFileFullPath withParam:(NSDictionary*)param;
+ (NSString*)checkResponseError:(NSString *)szResponse;
+ (void)cancelRequest;
+ (NSString*)getJsonStringFromDict:(NSDictionary*)dict;

+ (NSDictionary*)getDictFromJsonData:(NSData*)data;

+ (NSData*)decrypt:(NSData*)dataEncrypt;

@end
