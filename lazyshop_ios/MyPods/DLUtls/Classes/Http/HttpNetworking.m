//
//  HttpNetworking.m
//  MobileClassPhone
//
//  Created by SL on 16/5/10.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "HttpNetworking.h"

#import <MobileCoreServices/MobileCoreServices.h>

#import "HttpNetSetting.h"

static NSInteger netWorking = 0;

@interface HttpNetworking ()

@end

@implementation HttpNetworking

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"dealloc -- %@",self.class);
#endif
}

#pragma mark -单例
+ (instancetype)sharedInstance
{
    static HttpNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HttpNetworking alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -GET请求
+ (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(id)parameters
                     host:(NSString *)host
        completionHandler:(HttpHandler)completionHandler
{
    URLString = [HttpNetSetting fetchNewUrl:URLString
                                      isGet:YES];
    
    NSMutableURLRequest *mutableRequest = nil;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        NSMutableString *string = [NSMutableString stringWithString:URLString];
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [string appendFormat:@"&%@=%@",key,[NSString stringWithFormat:@"%@",obj]];
        }];
#ifdef DEBUG
        NSLog(@"\n\nhttp--get--%@\n\n",string);
#endif
        mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    } else if ([parameters isKindOfClass:[NSData class]]) {
        mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
        mutableRequest.HTTPBody = parameters;
    }else{
        mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
    mutableRequest.HTTPMethod = @"GET";
    mutableRequest.timeoutInterval = 10;
    if (![mutableRequest allHTTPHeaderFields][@"Host"] && host) {
        [mutableRequest addValue:host forHTTPHeaderField:@"Host"];
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[HttpNetSetting fetchNewRequest:mutableRequest]
                                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                         [self taskCompletionHandler:completionHandler
                                                                                                data:data
                                                                                            response:response
                                                                                               error:error
                                                                                                 url:URLString];
                                                                     }];
    if (completionHandler) {
        [self taskResume:dataTask];
    }
    
    return dataTask;
}

#pragma mark -POST请求
+ (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(id)parameters
                      host:(NSString *)host
         completionHandler:(HttpHandler)completionHandler
{
    URLString = [HttpNetSetting fetchNewUrl:URLString
                                      isGet:NO];
    
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        NSMutableString *string = [NSMutableString stringWithFormat:@""];
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [string appendFormat:([string isEqualToString:@""]?@"%@=%@":@"&%@=%@"),[self encodeURL:key],[self encodeURL:[NSString stringWithFormat:@"%@",obj]]];
        }];
#ifdef DEBUG
        NSLog(@"\n\nhttp--post--%@\n\n",[NSString stringWithFormat:@"%@?%@",URLString,string]);
#endif
        mutableRequest.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([parameters isKindOfClass:[NSData class]]) {
        mutableRequest.HTTPBody = parameters;
    }
    
    mutableRequest.HTTPMethod = @"POST";
    mutableRequest.timeoutInterval = 30;
    if (![mutableRequest allHTTPHeaderFields][@"Host"] && host) {
        [mutableRequest addValue:host forHTTPHeaderField:@"Host"];
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[HttpNetSetting fetchNewRequest:mutableRequest]
                                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                         [self taskCompletionHandler:completionHandler
                                                                                                data:data
                                                                                            response:response
                                                                                               error:error
                                                                                                 url:URLString];
                                                                     }];
    if (completionHandler) {
        [self taskResume:dataTask];
    }
    
    return dataTask;
}

#pragma mark -UPLOAD请求
+ (NSURLSessionTask *)UPLOAD:(NSString *)URLString
                  parameters:(id)parameters
                       files:(NSArray *)files
                    fileData:(NSData *)fileData
                    fileName:(NSString *)fileName
                        host:(NSString *)host
           completionHandler:(HttpHandler)completionHandler
{
    
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [mutableRequest setTimeoutInterval:30];
    
    // 请求头
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuid));
    CFRelease(uuid);
    NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    [mutableRequest addValue:[NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", stringBoundary] forHTTPHeaderField:@"Content-Type"];
    
    // 请求体-参数
    NSMutableData *body = [NSMutableData data];
    if (parameters) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *param1 = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",stringBoundary,key,obj,nil];
                [body appendData:[param1 dataUsingEncoding:NSUTF8StringEncoding]];
            }];
        } else if ([parameters isKindOfClass:[NSData class]]) {
            [body appendData:parameters];
        }
    }
    
    // 请求体-文件内容
    NSMutableArray *filesArray = [NSMutableArray new];
    [files enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData *data = [NSData dataWithContentsOfFile:obj];
        NSString *fileName = [obj lastPathComponent];
        [filesArray addObject:@{
                                @"data":data,
                                @"fileName":fileName,
                                }];
    }];
    if (fileData && fileName) {
        [filesArray addObject:@{
                                @"data":fileData,
                                @"fileName":fileName,
                                }];
    }
    [filesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[@"fileName"];
        NSString *file1 = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",stringBoundary,[name stringByDeletingPathExtension],name,nil];
        [body appendData:[file1 dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:obj[@"data"]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // body结束分割线
    NSString *endString = [NSString stringWithFormat:@"--%@--",stringBoundary];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    mutableRequest.HTTPBody = body;
    
    if (![mutableRequest allHTTPHeaderFields][@"Host"] && host) {
        [mutableRequest addValue:host forHTTPHeaderField:@"Host"];
    }
    
    NSURLSessionDataTask *uploadtask = [[NSURLSession sharedSession] dataTaskWithRequest:[HttpNetSetting fetchNewRequest:mutableRequest]
                                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                           [self taskCompletionHandler:completionHandler
                                                                                                  data:data
                                                                                              response:response
                                                                                                 error:error
                                                                                                   url:URLString];
                                                                       }];
    if (completionHandler) {
        [self taskResume:uploadtask];
    }
    return uploadtask;
}

#pragma mark -私有
// 开始请求
+ (void)taskResume:(NSURLSessionTask *)task
{
    netWorking++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [task resume];
}
// 请求结果处理
+ (void)taskCompletionHandler:(HttpHandler)completionHandler
                         data:(NSData *)data
                     response:(NSURLResponse *)response
                        error:(NSError *)error
                          url:(NSString *)url
{
    if (!error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
            //401公司授权业务处理（token失效http返回401）
            if (r.statusCode > 299 && r.statusCode != 401) {
                error = [NSError errorWithDomain:@"com.zxtech.err"
                                            code:r.statusCode
                                        userInfo:@{@"errorInfo":[NSString stringWithFormat:@"Connection Fail,code = %d.",r.statusCode]}];
            }
        }
    } else if (error.code == -1001){
        error = [NSError errorWithDomain:@"com.zxtech.err" code:-1001 userInfo:@{@"errorInfo":@"请求超时"}];
    }
    //-999是自动取消请求，-1001是超时
#ifdef DEBUG
    if (error) {
        NSLog(@"\n\nhttperror====%@====%@====%d\n\n",url,error,error.code);
    }
#endif
    if (completionHandler && error.code!=-999) {
        completionHandler(data,response,error);
    }
    netWorking--;
    if (netWorking<=0) {
        netWorking = 0;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}
// URL相关字符串处理
+ (NSString *)encodeURL:(NSString *)string
{
    if (string != nil && ![string isEqual:[NSNull null]]) {
        NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@",string], nil, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
        if (newString) {
            return newString;
        }
    }
    return @"";
}

@end
