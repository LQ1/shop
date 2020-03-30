//
//  HttpHelper.m
//  GovGenoffice
//
//  Created by xtkj on 15/4/27.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//

#import "HttpHelper.h"
#import "GTMBase64.h"
#import "GlobalSetting.h"
#import "AFHTTPRequestOperationManager.h"

@implementation HttpHelper

- (id)init{
    self = [super init];
    return self;
}

+ (NSString*)getPerfixUrl{
    return [NSString stringWithFormat:@"http://%@",APP_DOMAIN];//@"http://wp.96199cn.com";
}
/*
 b获取请求的全路径
 */
+ (NSString*)getRemoteMethodInvoke
{
    return [NSString stringWithFormat:@"%@/",[self getPerfixUrl]];
}
+ (NSString*)getUrl:(NSString*)szURL{
    return [NSString stringWithFormat:@"%@%@",[self getRemoteMethodInvoke],szURL];
}

+ (NSData*)sendPostRequest:(NSString*)szURL{
    __block NSData *responseData = nil;
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [afManager POST:szURL parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject) {
                            NSLog(@"AFResponse Data ***%@",operation.responseString);
                            responseData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"AFResponse Data Failed:%@",error);
                            NSString *szErr = [error localizedDescription];
                            NSLog(@"%@\n",szErr);
    }];
    
    //[GlobalSetting sharedInstance].request = request;
    //默认10s超时
    //如果发生Error Domain=NSURLErrorDomain Code=-1000 "bad URL" UserInfo=0x14defc80 {NSUnderlyingError=0x14deea10 "bad URL", NSLocalizedDescription=bad URL这个错误，请检查URL编码格式。有没有进行stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding;
    return responseData;
}

//请求数据
+ (NSData*)sendPostRequest:(NSString *)szURL withParam:(NSDictionary *)param withError:(NSError *__autoreleasing *)error
{
    //NSMutableDictionary *paramNews = [NSMutableDictionary new];
    __block NSData *responseData = nil;
    NSString *szFullUrl = [self getUrl:szURL];
    if ([Utility stringContainSubStr:szURL withSubStr:@"http"]) {
        szFullUrl = szURL;
    }
    
    
    NSError *err;
    
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];//HTTP方式请求
//    [requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Charset"];
//    [requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"POST" URLString:szFullUrl parameters:param error:&err];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    NSLog(@"***response text    %@",[requestOperation responseString]);
    responseData = [requestOperation responseData];

    
    /*  这种事件的方式,以目前我的框架而言不太可用，用上面同步的方式
    [afManager POST:szFullUrl parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"AFResponse Data ***%@",operation.responseString);
        responseData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        responseData = [self decrypt:responseData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error1) {
        NSLog(@"AFResponse Data Failed:%@",error1);
        NSString *szErr = [error1 localizedDescription];
        NSLog(@"%@\n",szErr);
        *error = [[NSError alloc] initWithDomain:szErr code:1000 userInfo:nil];
    }];*/
    
    return responseData;
}


//请求数据
+ (NSData*)sendGetRequest:(NSString *)szURL withParam:(NSDictionary *)param withError:(NSError *__autoreleasing *)error
{
    NSMutableDictionary *paramNews = [NSMutableDictionary new];
    __block NSData *responseData = nil;
    NSString *szFullUrl = [self getUrl:szURL];
    
    
    //NSString *szJsonParams = [self getJsonStringFromDict:param];
    //参数格式太乱了，3种全部加上...................
    [paramNews setDictionary:param];
    
    
    NSError *err;
    
    //AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];json格式请求 直接发送JSON
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];//HTTP方式请求
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:szFullUrl parameters:paramNews error:&err];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    NSLog(@"***response text    %@",[requestOperation responseString]);
    responseData = [requestOperation responseData];
    
    
    return responseData;
}

+ (NSString*)getJsonStringFromDict:(NSDictionary *)dict{
    NSString *jsonStr = @"{";
    NSEnumerator *enumer = [dict keyEnumerator];
    
    for (NSString *szKey in enumer) {
        NSString *szValue = [dict objectForKey:szKey];
        jsonStr = [jsonStr stringByAppendingFormat:@"\"%@\":\"%@\",",szKey,szValue];
    }
    jsonStr = [[jsonStr substringToIndex:(jsonStr.length - 1)] stringByAppendingString:@"}"];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
    
    //jsonStr = [jsonStr stringByURLEncode];
    //jsonStr = [jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return jsonStr;
}

//取消请求
+ (void)cancelRequest
{
    /*
    if ([GlobalSetting sharedInstance].request) {
        [[GlobalSetting sharedInstance].request cancel];
    }
     */
}

//获取上传文件的URL地址
+ (NSURL*)getPostFileURL:(NSString *)szFileFullPath withParam:(NSDictionary *)param
{
    NSString *szParam = [NSString stringWithFormat:@"Action=uploadCollectionInfo&UserID=%@&DeclareID=%@&FileType=1&fileName=%@",[param objectForKey:@"UserID"],[param objectForKey:@"DeclareID"],[param objectForKey:@"FileName"]];
    NSString *szUTF8 = [NSString stringWithFormat:@"http://61.166.240.109:6011/uploadTest.app?%@",szParam];
    szUTF8 = [szUTF8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:szUTF8];
    return url;
}

//上传文件，无法设置进度条
+ (NSData*)sendPostFileRequest:(NSString*)szFileFullPath withParam:(NSDictionary *)param
{
    NSData *szRet = nil;
    /*
    NSString *szParam = [NSString stringWithFormat:@"Action=uploadCollectionInfo&UserID=%@&DeclareID=%@&FileType=1&fileName=%@",[param objectForKey:@"UserID"],[param objectForKey:@"DeclareID"],[param objectForKey:@"FileName"]];
    //NSURL *url = [NSURL URLWithString:@"http://192.168.1.105/test.app"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.105/test.app?%@",szParam]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.showAccurateProgress = YES;
    NSError *error = nil;
    
     NSEnumerator *enumertor = param.keyEnumerator;
     for (NSString *key in enumertor) {
     [request addPostValue:[param objectForKey:key] forKey:key];
     }*/
    /*
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setRequestMethod:@"POST"];
    [request setPostBodyFilePath:szFileFullPath];
    [request setShouldStreamPostDataFromDisk:YES];
    
    [request startSynchronous];
    error = [request error];
    if (!error) {
        szRet = [request responseData];
    }else{
        //NSString *szErr = [error localizedDescription];
        //[self showMessage:[self checkResponseError:szErr]];
    }*/
    return szRet;
}



+ (NSString*)checkResponseError:(NSString *)szResponse{
    //检查消息是否包含错误前缀
    //
    //if(![szResponse hasPrefix:[Constant sharedConstant].G_WEBSERVICE_ERROR]) {
    
    //    return@"";
    
    //}
    
    //else
    {
        NSMutableString *sTemp = [[NSMutableString alloc] initWithString:szResponse];
        
        //获取错误前缀的范围
        
        //NSRange range=[sTemp rangeOfString:[Constant sharedConstant].G_WEBSERVICE_ERROR];
        
        //剔除错误前缀
        
        //[sTemp replaceCharactersInRange:range withString:@""];
        NSString* errMsg = sTemp;
        //Authentication needed
        if([sTemp isEqualToString:@"Authentication needed"]) {
            errMsg = @"用户登录失败！";
        }
        //The request timed out
        if([sTemp isEqualToString:@"The request timed out"]) {
            errMsg = @"访问超时，请检查远程地址等基本设置！";
        }
        //The request was cancelled
        if([sTemp isEqualToString:@"The request was cancelled"]) {
            errMsg = @"请求被撤销！";
        }
        //Unable to create request (bad url?)
        if([sTemp isEqualToString:@"Unable to create request (bad url?)"]) {
            errMsg = @"无法创建请求，错误的URL地址！";
        }
        //The request failed because it redirected too many times
        if([sTemp isEqualToString:@"The request failed because it redirected too many times"]) {
            errMsg = @"请求失败，可能是因为被重定向次数过多！";
        }
        //A connection failure occurred
        if([sTemp isEqualToString:@"A connection failure occurred"]) {
            errMsg = @"网络连接错误，请检查无线或3G网络设置！";
        }
        return errMsg;
    }
}

//从NSData解析JSON串
+ (NSDictionary*)getDictFromJsonData:(NSData *)data
{
    if (data) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj isKindOfClass:[NSDictionary class]]) {
            return jsonObj;
        }
    }
    return nil;
}

+ (NSDate*)dateFromNSString:(NSString *)szDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = nil;
    if (szDate && ![szDate isEqual:[NSNull null]]) {
        date = [dateFormat dateFromString:szDate];
    }
    return date;
}


//////////////自定义封装Multipart/form-data/////////////////
+ (BOOL)sendPhotoToTumblr:(NSString *)szFilePath withURL:(NSURL*)url withCaption:(NSDictionary *)params{
    //get image data from file
    NSData *imageData = [NSData dataWithContentsOfFile:szFilePath];
    //stop on error
    if (!imageData) return NO;
    //create tumblr photo post
    NSURLRequest *tumblrPost = [self createTumblrRequest:url withParams:params withData:imageData];
    //send request, return YES if successful
    NSURLConnection *tumblrConnection = [[NSURLConnection alloc] initWithRequest:tumblrPost delegate:self];
    if (!tumblrConnection) {
        NSLog(@"Failed to submit request");
        return NO;
    } else {
        NSLog(@"Request submitted");
        //receivedData = [[NSMutableData data] retain];
        return YES;
    }
}

+ (NSURLRequest *)createTumblrRequest:(NSURL*)url withParams:(NSDictionary *)postKeys withData:(NSData *)data1
{
    //create the URL POST Request to tumblr
    NSMutableURLRequest *tumblrPost = [NSMutableURLRequest requestWithURL:url];
    [tumblrPost setHTTPMethod:@"POST"];
    //Add the header info
    NSString *stringBoundary = @"0xKhTmLbOuNdArY";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
    [tumblrPost addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //add key values from the NSDictionary object
    NSEnumerator *keys = [postKeys keyEnumerator];
    int i;
    for (i = 0; i < [postKeys count]; i++) {
        NSString *tempKey = [keys nextObject];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",[postKeys objectForKey:tempKey]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //add data field and file data
    [postBody appendData:[@"Content-Disposition: form-data; name=\"File\";filename=\"test.amr\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[NSData dataWithData:data1]];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];

    //add the body to the post
    [tumblrPost setHTTPBody:postBody];
    return tumblrPost;
}

+ (NSString*)encrypt:(NSString*)szStr{
    NSData *data = [szStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *szEncrypt = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    data = [GTMBase64 encodeData:data];
    NSString *szEncrypt = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //szEncrypt = [szEncrypt stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return szEncrypt;
}

//解密
+ (NSData*)decrypt:(NSData*)dataEncrypt{
    if (dataEncrypt) {
        //去除邮服务端返回的dataEncrypt的前后"号
        NSString *szData = [[NSString alloc] initWithData:dataEncrypt encoding:NSUTF8StringEncoding];
        NSRange range;
        range.location = 1;
        range.length = szData.length - 2;
        szData = [szData substringWithRange:range];
        NSData *data = [szData dataUsingEncoding:NSUTF8StringEncoding];
        NSData *dataNew = [GTMBase64 decodeData:data];
        long nLen = dataNew.length;
        Byte *bufs = (Byte*)[dataNew bytes];
        for (int i=0; i<nLen; i++) {
            bufs[i]=bufs[i]^0x0D;
        }
        dataNew = [[NSData alloc] initWithBytes:bufs length:nLen];
        return dataNew;
    }
    return nil;
}







@end
