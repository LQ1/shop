//
//  HttpNetSetting.m
//  Pods
//
//  Created by Eggache_Yang on 2017/7/25.
//
//

#import "HttpNetSetting.h"

@implementation HttpNetSetting

#pragma mark -域名劫持处理
+ (id)fetchIPUrl:(id)oldUrl
{
    NSURL *currentPlayUrl = [NSURL URLWithString:oldUrl];
    NSString *httpUrl = currentPlayUrl.absoluteString;
    
//    NSString *host = currentPlayUrl.host;
//    if ([host rangeOfString:@"zctech"].location == NSNotFound) {
//        NSString *urlHost = @"211.157.0.5";
//        httpUrl = [currentPlayUrl.absoluteString stringByReplacingOccurrencesOfString:currentPlayUrl.host withString:urlHost];
//    }
    
    return httpUrl;
}

#pragma mark -拼接通用参数
+ (id)fetchNewUrl:(id)oldUrl
            isGet:(BOOL)isGet
{
//    if (oldUrl != nil && ![oldUrl isEqual:[NSNull null]])
//    {
//        NSMutableDictionary *info = [NSMutableDictionary new];
//        // 添加通用参数
//        info[@"_t"] = @(arc4random());
    
//        NSMutableString *string = [NSMutableString stringWithString:oldUrl];
//        [info enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            [string appendFormat:([string rangeOfString:@"?"].location==NSNotFound?@"?%@=%@":@"&%@=%@"),key,[NSString stringWithFormat:@"%@",obj]];
//        }];
//        return string;
//    }
//    return oldUrl;
    if (isGet) {
        oldUrl = [oldUrl stringByAppendingString:@"?"];
    }
    return oldUrl;
}

#pragma mark -拼接请求头
+ (NSURLRequest *)fetchNewRequest:(NSMutableURLRequest *)request
{
//    if (![request allHTTPHeaderFields][@"Content-Type"]) {
//        [request addValue:@"*/*" forHTTPHeaderField:@"Content-Type"];
//    }
    return request;
}

@end
