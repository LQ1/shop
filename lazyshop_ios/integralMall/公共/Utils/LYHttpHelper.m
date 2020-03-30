//
//  LYHttpHelper.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYHttpHelper.h"

#import <JSONKit-NoWarning/JSONKit.h>

#import <DLUtls/DLHttpUtls.h>

@implementation LYHttpHelper

#pragma mark -GET请求
+ (RACSignal *)GET:(NSString *)url
            params:(id)params
          dealCode:(BOOL)dealCode
{
    url = [self fetchPlatformAndVersionUrlWith:url];
    return [self httpEncMethod:YES
                           url:url
                        params:params
                   filterError:dealCode
                          json:dealCode];
}

#pragma mark -POST请求
+ (RACSignal *)POST:(NSString *)url
             params:(id)params
           dealCode:(BOOL)dealCode
{
    url = [self fetchPlatformAndVersionUrlWith:url];
    return [self httpEncMethod:NO
                           url:url
                        params:params
                   filterError:dealCode
                          json:dealCode];
}

#pragma mark -UPLOAD请求
+ (RACSignal *)UPLOAD:(NSString *)url
               params:(id)params
                files:(NSArray *)files
             fileData:(NSData *)fileData
             fileName:(NSString *)fileName {
    url = [self fetchPlatformAndVersionUrlWith:url];
    RACSignal *signal = [self fetchNetStatus];
    if (!signal) {
        signal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            DLCancelBolck cancelBlock = [DLHttpUtls DLUploadAsynchronous:url
                                                              parameters:params
                                                                   files:files
                                                                fileData:fileData
                                                                fileName:fileName
                                                            locationFile:nil
                                                                complete:^(NSString *str) {
                                                                    CLog(@"接口返回：%@--%@",url,str);
                                                                    [subscriber sendNext:str];
                                                                    [subscriber sendCompleted];
                                                                } fail:^(NSError *err) {
                                                                    CLog(@"接口错误：%@--%@",url,err);
                                                                    if ([err.domain isEqualToString:CustomErrorDomain]) {
                                                                        [subscriber sendError:err];
                                                                    } else {
                                                                        NSError *error = [NSError errorWithDomain:CustomErrorDomain
                                                                                                             code:DLDataFailed
                                                                                                         userInfo:@{AppErrorMsgKey:ERROR_NORMAL_SHOW}];
                                                                        [subscriber sendError:error];
                                                                    }
                                                                }];
            return [RACDisposable disposableWithBlock:^{
                cancelBlock();
            }];
        }];
    }
    return [self dealResultValue:signal
                     filterError:YES
                            json:YES];
}

#pragma mark -私有方法
// 获取拼接平台号和版本号的网址
+ (NSString *)fetchPlatformAndVersionUrlWith:(NSString *)oldUrl
{
    NSString *prefix = @"http://"APP_DOMAIN@"/";
    NSString *midStr = [NSString stringWithFormat:@"ios/v%@/",[CommUtls getSoftShowVersion]];
    NSString *newPrefix = [prefix stringByAppendingString:midStr];
    if ([oldUrl hasPrefix:prefix]&&![oldUrl hasPrefix:newPrefix]) {
        oldUrl = [oldUrl stringByReplacingOccurrencesOfString:prefix
                                                   withString:newPrefix];
    }
    return oldUrl;
}
// 公共请求
+ (RACSignal *)httpEncMethod:(BOOL)isGet
                         url:(NSString *)url
                      params:(id)params
                 filterError:(BOOL)filterError
                        json:(BOOL)json
{
    RACSignal *signal = [self fetchNetStatus];
    if (!signal) {
        if (isGet) {
            signal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
                DLCancelBolck cancelBlock = [DLHttpUtls DLCryptoGetAsynchronous:url parameters:params locationFile:nil complete:^(NSString *str) {
                    CLog(@"接口返回：网址：%@--返回数据：%@",url,str);
                    [subscriber sendNext:str];
                    [subscriber sendCompleted];
                } fail:^(NSError *err) {
                    CLog(@"接口错误：网址：%@--返回数据：%@",url,err);
                    if ([err.domain isEqualToString:CustomErrorDomain]) {
                        [subscriber sendError:err];
                    } else {
                        NSError *error = [NSError errorWithDomain:CustomErrorDomain
                                                             code:DLDataFailed
                                                         userInfo:@{AppErrorMsgKey:ERROR_NORMAL_SHOW}];
                        [subscriber sendError:error];
                    }
                } cryptoKey:nil desKey:nil];
                
                return [RACDisposable disposableWithBlock:^{
                    cancelBlock();
                }];
            }];
        } else {
            signal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
                DLCancelBolck cancelBlock = [DLHttpUtls DLCryptoPostAsynchronous:url parameters:params locationFile:nil complete:^(NSString *str) {
                    CLog(@"接口返回：网址：%@--返回数据：%@",url,str);
                    [subscriber sendNext:str];
                    [subscriber sendCompleted];
                } fail:^(NSError *err) {
                    CLog(@"接口错误：网址：%@--返回数据：%@",url,err);
                    if ([err.domain isEqualToString:CustomErrorDomain]) {
                        [subscriber sendError:err];
                    } else {
                        NSError *error = [NSError errorWithDomain:CustomErrorDomain
                                                             code:DLDataFailed
                                                         userInfo:@{AppErrorMsgKey:ERROR_NORMAL_SHOW}];
                        [subscriber sendError:error];
                    }
                } cryptoKey:nil desKey:nil];
                
                return [RACDisposable disposableWithBlock:^{
                    cancelBlock();
                }];
            }];
        }
    }
    
    return [self dealResultValue:signal
                     filterError:filterError
                            json:json];
}
// 网络状态信号
+ (RACSignal *)fetchNetStatus
{
    if ([NetStatusHelper sharedInstance].netStatus == NoneNet) {
        NSError *error = [NSError errorWithDomain:CustomErrorDomain
                                             code:DLNoNet
                                         userInfo:@{AppErrorMsgKey:NO_NET_STATIC_SHOW}];
        return [RACSignal error:error];
    }
    return nil;
}
// 接口返回数据处理
+ (RACSignal *)dealResultValue:(RACSignal *)signal
                   filterError:(BOOL)filterError
                          json:(BOOL)json
{
    return [signal flattenMap:^RACStream *(id value) {
        if (json) {
            NSDictionary *data = [value objectFromJSONString];
            NSString *err = nil;
            if (data) {
                if ([data isKindOfClass:[NSDictionary class]]) {
                    if ([data[@"code"] integerValue] == 1 || !filterError) {
#ifdef DEBUG
                        NSString *jsonString = [data JSONString];
                        printf("\n接口数据:%s\n\n",[jsonString UTF8String]);
#endif
                        return [RACSignal return:data];
                    }else if (NodeExist(data[@"msg"])) {
                        err = data[@"msg"];
                    }else{
                        err = AppErrorMsg;
                    }
                } else {
                    return [RACSignal return:data];
                }
            }else{
                err = AppNetErrorMsg;
            }
            CLog(@"\n错误信息:\n对用户:%@\n对开发者:%@",err,data[@"imsg"]);
            NSError *error = [NSError errorWithDomain:CustomErrorDomain
                                                 code:[data[@"code"] integerValue]
                                             userInfo:@{AppErrorMsgKey:err}];
            return [RACSignal error:error];
        }else {
#ifdef DEBUG
            printf("\n接口数据:%s\n\n",[value UTF8String]);
#endif
            return [RACSignal return:value];
        }
    }];
}

@end
