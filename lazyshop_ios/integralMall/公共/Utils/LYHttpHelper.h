//
//  LYHttpHelper.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYHttpHelper : NSObject


/**
 GET请求

 @param url        url
 @param params     参数
 @param dealCode   YES 自动处理code 返回成功的dictionary 
                    NO 返回jsonString
 @return <#return value description#>
 */
+ (RACSignal *)GET:(NSString *)url
            params:(id)params
          dealCode:(BOOL)dealCode;

/**
 POST请求
 
 @param url        url
 @param params     参数
 @param dealCode   YES 自动处理code 返回成功的dictionary
 NO 返回jsonString
 @return <#return value description#>
 */
+ (RACSignal *)POST:(NSString *)url
             params:(id)params
           dealCode:(BOOL)dealCode;

/**
 *  上传文件
 *  files或者fileData、fileName传入有效
 *
 *  @param url      上传地址
 *  @param params   参数
 *  @param files    本地文件地址（带后缀的NSString数组）
 *  @param fileData 上传的数据
 *  @param fileName 上传的名称(带后缀)
 *
 *  @return <#return value description#>
 */
+ (RACSignal *)UPLOAD:(NSString *)url
               params:(id)params
                files:(NSArray *)files
             fileData:(NSData *)fileData
             fileName:(NSString *)fileName;


/*
 *  获取添加了平台号/版本号的网址
 */
+ (NSString *)fetchPlatformAndVersionUrlWith:(NSString *)oldUrl;

+ (RACSignal *)httpEncMethod:(BOOL)isGet
                         url:(NSString *)url
                      params:(id)params
                 filterError:(BOOL)filterError
                        json:(BOOL)json;

@end
