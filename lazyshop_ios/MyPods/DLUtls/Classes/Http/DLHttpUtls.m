//
//  HttpUtls.m
//  DL
//
//  Created by cyx on 14-9-17.
//  Copyright (c) 2014年 Cdeledu. All rights reserved.
//

#import "CommUtls.h"

#import <JSONKit-NoWarning/JSONKit.h>
#import <MD5Digest/NSString+MD5.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

#import "DLHttpUtls.h"
#import "HttpNetworking.h"
#import "HttpNetSetting.m"

@implementation DLHttpUtls

#pragma mark -异步get
+ (DLCancelBolck)DLGetAsynchronous:(NSString *)url
                        parameters:(id)params
                      locationFile:(NSString *)file
                          complete:(DLCompleteBlock)aCompletionBlock
                              fail:(DLFailBlock)aFailBlock
{
    __block NSURLSessionTask *_request = nil;
    __block NSURLSessionTask *_request1 = nil;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        _request = [HttpNetworking GET:url
                            parameters:params
                                  host:nil
                     completionHandler:^(NSData *data1, NSURLResponse *response1, NSError *error1) {
                         if (error1) {
                             _request1 = [HttpNetworking GET:[HttpNetSetting fetchIPUrl:url]
                                                  parameters:params
                                                        host:[[NSURL URLWithString:url] host]
                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                               [self dealData:data
                                                     response:response
                                                        error:error
                                                          url:[HttpNetSetting fetchIPUrl:url]
                                                   parameters:params
                                                     complete:aCompletionBlock
                                                         fail:aFailBlock];
                                           }];
                         }else {
                             [self dealData:data1
                                   response:response1
                                      error:error1
                                        url:url
                                 parameters:params
                                   complete:aCompletionBlock
                                       fail:aFailBlock];
                         }
                     }];
    }];
    return ^{
        if (_request) {
            [_request cancel];
        }
        if (_request1) {
            [_request1 cancel];
        }
        [queue cancelAllOperations];
    };
}

#pragma mark -同步get
+ (id)DLGetSynchronous:(NSString *)url
            parameters:(id)params
          locationFile:(NSString *)file
{
    __block NSString *responseStr = nil;
    __block NSError *err = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [HttpNetworking GET:url
             parameters:params
                   host:nil
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          if (error) {
              err = error;
          } else {
              responseStr = [self parseNetData:data response:response];
          }
          dispatch_semaphore_signal(semaphore);
      }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (responseStr) {
        return responseStr;
    } else {
        [HttpNetworking GET:[HttpNetSetting fetchIPUrl:url]
                 parameters:params
                       host:[[NSURL URLWithString:url] host]
          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              if (error) {
                  err = error;
              } else {
                  responseStr = [self parseNetData:data response:response];
              }
              dispatch_semaphore_signal(semaphore);
          }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        if (responseStr) {
            return responseStr;
        } else if (err){
            return err;
        }
    }
    return nil;
}

#pragma mark -异步post
+ (DLCancelBolck)DLPostAsynchronous:(NSString *)url
                         parameters:(id)params
                       locationFile:(NSString *)file
                           complete:(DLCompleteBlock)aCompletionBlock
                               fail:(DLFailBlock)aFailBlock
{
    __block NSURLSessionTask *_request = nil;
    __block NSURLSessionTask *_request1 = nil;
    
    //循环调用ok
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        _request = [HttpNetworking POST:url
                             parameters:params
                                   host:nil
                      completionHandler:^(NSData *data1, NSURLResponse *response1, NSError *error1) {
                          if (error1) {
                              _request1 = [HttpNetworking POST:[HttpNetSetting fetchIPUrl:url]
                                                    parameters:params
                                                          host:[[NSURL URLWithString:url] host]
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 [self dealData:data
                                                       response:response
                                                          error:error
                                                            url:[HttpNetSetting fetchIPUrl:url]
                                                     parameters:params
                                                       complete:aCompletionBlock
                                                           fail:aFailBlock];
                                             }];
                          }else {
                              [self dealData:data1
                                    response:response1
                                       error:error1
                                         url:url
                                  parameters:params
                                    complete:aCompletionBlock
                                        fail:aFailBlock];
                          }
                      }];
    }];
    return ^{
        if (_request) {
            [_request cancel];
        }
        if (_request1) {
            [_request1 cancel];
        }
        [queue cancelAllOperations];
    };
}

#pragma mark -异步upload
+ (DLCancelBolck)DLUploadAsynchronous:(NSString *)URLString
                           parameters:(id)parameters
                                files:(NSArray *)files
                             fileData:(NSData *)fileData
                             fileName:(NSString *)fileName
                         locationFile:(NSString *)file
                             complete:(DLCompleteBlock)aCompletionBlock
                                 fail:(DLFailBlock)aFailBlock
{
    __block NSURLSessionTask *_request = nil;
    __block NSURLSessionTask *_request1 = nil;
    
    //循环调用ok
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        _request = [HttpNetworking UPLOAD:URLString
                               parameters:parameters
                                    files:files
                                 fileData:fileData
                                 fileName:fileName
                                     host:nil
                        completionHandler:^(NSData *data1, NSURLResponse *response1, NSError *error1) {
                            if (error1) {
                                _request1 = [HttpNetworking UPLOAD:[HttpNetSetting fetchIPUrl:URLString]
                                                        parameters:parameters
                                                             files:files
                                                          fileData:fileData
                                                          fileName:fileName
                                                              host:[[NSURL URLWithString:URLString] host]
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     [self dealData:data
                                                           response:response
                                                              error:error
                                                                url:[HttpNetSetting fetchIPUrl:URLString]
                                                         parameters:parameters
                                                           complete:aCompletionBlock
                                                               fail:aFailBlock];
                                                 }];
                            }else {
                                [self dealData:data1
                                      response:response1
                                         error:error1
                                           url:URLString
                                    parameters:parameters
                                      complete:aCompletionBlock
                                          fail:aFailBlock];
                            }
                        }];
    }];
    return ^{
        if (_request) {
            [_request cancel];
        }
        if (_request1) {
            [_request1 cancel];
        }
        [queue cancelAllOperations];
    };
}

#pragma mark -加密get
+ (DLCancelBolck)DLCryptoGetAsynchronous:(NSString *)url
                              parameters:(id)params
                            locationFile:(NSString *)file
                                complete:(DLCompleteBlock)aCompletionBlock
                                    fail:(DLFailBlock)aFailBlock
                               cryptoKey:(NSString *)cryptoKey
                                  desKey:(NSString *)desKey
{
    // 可根据key处理params
    return [self DLGetAsynchronous:url
                        parameters:params
                      locationFile:file
                          complete:aCompletionBlock
                              fail:aFailBlock];
}

#pragma mark -加密post
+ (DLCancelBolck)DLCryptoPostAsynchronous:(NSString *)url
                               parameters:(id)params
                             locationFile:(NSString *)file
                                 complete:(DLCompleteBlock)aCompletionBlock
                                     fail:(DLFailBlock)aFailBlock
                                cryptoKey:(NSString *)cryptoKey
                                   desKey:(NSString *)desKey
{
    // 可根据key处理params
    return [self DLPostAsynchronous:url
                         parameters:params
                       locationFile:file
                           complete:aCompletionBlock
                               fail:aFailBlock];
}

#pragma mark -数据处理
+ (void)dealData:(NSData *)data
        response:(NSURLResponse *)response
           error:(NSError *)error
             url:(NSString *)url
      parameters:(id)params
        complete:(DLCompleteBlock)aCompletionBlock
            fail:(DLFailBlock)aFailBlock
{
    NSError *err = nil;
    NSString *responseStr = nil;
    if (error) {
        err = error;
    } else {
        responseStr = [self parseNetData:data response:response];
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (responseStr != nil) {
            if(aCompletionBlock) {
                aCompletionBlock(responseStr);
            }
        } else if(aFailBlock) {
            aFailBlock(err);
        }
    }];
}

+ (NSString *)parseNetData:(NSData *)data response:(NSURLResponse *)response
{
    if (data) {
        NSStringEncoding *stringEncoding = nil;
        NSString *textEncodingName = response.textEncodingName;
        if (textEncodingName != nil && ![textEncodingName isEqual:[NSNull null]]) {
            CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)textEncodingName);
            if (cfEncoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
            }
        }
        if (stringEncoding) {
            return [[NSString alloc] initWithData:data encoding:stringEncoding];
        }
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
