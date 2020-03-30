//
//  HttpNetSetting.h
//  Pods
//
//  Created by Eggache_Yang on 2017/7/25.
//
//

#import <Foundation/Foundation.h>

@interface HttpNetSetting : NSObject

/**
 域名劫持逻辑处理
 
 @param oldUrl <#oldUrl description#>
 @return <#return value description#>
 */
+ (id)fetchIPUrl:(id)oldUrl;


/**
 拼接通用参数

 @param oldUrl <#oldUrl description#>
 @return <#return value description#>
 */
+ (id)fetchNewUrl:(id)oldUrl
            isGet:(BOOL)isGet;


/**
 拼接请求头

 @param request <#request description#>
 @return <#return value description#>
 */
+ (NSURLRequest *)fetchNewRequest:(NSMutableURLRequest *)request;

@end
