//
//  BaseService.m
//  HomeDecoration
//
//  Created by xtkj on 15/6/12.
//  Copyright (c) 2015年 anz. All rights reserved.
//

#import "BaseViewModel1.h"

@implementation BaseViewModel1

- (id)init{
    self = [super init];
    dictParams = [NSMutableDictionary new];
    self.ERROR_MSG = @"连接超时,请检查网络设置";
    return self;
}

- (void)initArrayParams:(NSString*)szKeyTag{
    NSMutableDictionary *dictParams1 = [dictParams objectForKey:szKeyTag];
    
    if (dictParams1 == nil) {
        dictParams1 = [NSMutableDictionary new];
        [dictParams setObject:dictParams1 forKey:szKeyTag];
    }else{
        [dictParams1 removeAllObjects];
    }
    
    if([AccountService shareInstance].isLogin){
        [dictParams1 setObject:SignInToken forKey:@"token"];
    }
}

- (void)addParams:(NSString*)szKeyTag withKey:(NSString*)szKey withStringValue:(NSString*)szValue{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:szValue forKey:szKey];
}

- (void)addParams:(NSString*)szKeyTag withKey:(NSString*)szKey withDoubleValue:(CGFloat)dValue{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:[NSNumber numberWithDouble:dValue] forKey:szKey];
}

//添加一个字典集合
- (void)addParams:(NSString*)szTagKey withDictionary:(NSDictionary*)dictionary{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szTagKey];
    for (NSString *szKey in dictionary.keyEnumerator) {
        [dictParamsNew setObject:[dictionary objectForKey:szKey] forKey:szKey];
    }
}

- (void)addParams:(NSString*)szKeyTag withKey:(NSString *)szKey withIntValue:(int)nValue{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:[NSString stringWithFormat:@"%d",nValue] forKey:szKey];
}

- (void)addParams:(NSString*)szKeyTag withKey:(NSString *)szKey withLongValue:(long)nValue{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:[NSString stringWithFormat:@"%ld",nValue] forKey:szKey];
}

- (void)addParamsPageNum:(NSString*)szKeyTag withNum:(int)nPageNum{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:[NSString stringWithFormat:@"%d",nPageNum] forKey:@"pageNum"];
}

- (void)addParamsId:(NSString*)szKeyTag withId:(int)nId{
    NSMutableDictionary *dictParamsNew = [dictParams objectForKey:szKeyTag];
    [dictParamsNew setObject:[NSString stringWithFormat:@"%d",nId] forKey:@"Id"];
}


//从服务器获取数据
- (BOOL)getDataFromService:(NSString*)szKeyTag withPage:(NSString*)szPageName{

    NSError *err;
    NSData *data = [HttpHelper sendPostRequest:szPageName withParam:[dictParams objectForKey:szKeyTag] withError:&err];
    if (!err) {
        return [self isOk:data];
    }
    self.ERROR_MSG = [err localizedDescription];
    return NO;
}

//从服务器获取数据
- (BOOL)getDataFromService_GET:(NSString*)szKeyTag withPage:(NSString*)szPageName{
    
    NSError *err;
    NSData *data = [HttpHelper sendGetRequest:szPageName withParam:[dictParams objectForKey:szKeyTag] withError:&err];
    NSLog(@"-------- %@",[dictParams objectForKey:szKeyTag]);
    if (!err) {
        return [self isOk:data];
    }
    self.ERROR_MSG = [err localizedDescription];
    return NO;
}

//从服务器获取数据
- (NSData*)getDataFromService_GET_1:(NSString*)szKeyTag withPage:(NSString*)szPageName{
    
    NSError *err;
    NSData *data = [HttpHelper sendGetRequest:szPageName withParam:[dictParams objectForKey:szKeyTag] withError:&err];
    return data;
}

//返回服务端对信息错误或正确的描述
/*
- (SimpleReturn*)getDataFromService:(NSString*)szPageName{
    SimpleReturn *simpleRet = [SimpleReturn new];
    NSError *err;
    NSData *data = [HttpHelper sendPostRequest:szPageName withParam:dictParams withJsonParam:dictJsonParams withError:&err];
    if (!err) {
        if ([self isOk:data]) {
            simpleRet.isSuccess = YES;
        }
        simpleRet.szDesc = [self getSingleValueByResultMessage];
    }else{
        self.ERROR_MSG = [err localizedDescription];
    }
    
    return simpleRet;
}*/

- (BOOL)isOk:(NSData *)dataResult{
    NSError *err;
    BOOL bRet = NO;
    if (!dataResult) {
        return NO;
    }
    //decrypt
    //dataResult = [HttpHelper decrypt:dataResult];
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingAllowFragments error:&err];
    if (!err) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"**********%@**************",json);
            dctRootJsonValue = (NSDictionary*)json;
            if ([[dctRootJsonValue objectForKey:@"code"] integerValue] != 1) {
                self.ERROR_MSG = [dctRootJsonValue objectForKey:@"msg"];
                if ([@"" isEqualToString:self.ERROR_MSG] || self.ERROR_MSG == nil || [self.ERROR_MSG isKindOfClass:[NSNull class]]) {
                    self.ERROR_MSG = @"查询失败";
                }
            }else{
                bRet = YES;
            }
        }else{
            self.ERROR_MSG = @"数据错误";
        }
    }else{
        self.ERROR_MSG = [err localizedDescription];
    }
    return bRet;
}

//获取单个值
- (NSString*)getSingleValueByResultObject{
    NSString *szRet = @"";
    if (dctRootJsonValue) {
        szRet = [dctRootJsonValue objectForKey:@"data"];
    }
    return szRet;
}

- (int)getIntValueByResult{
    return [[self getSingleValueByResultObject] intValue];
}

//获取描述
- (NSString*)getSingleValueByResultMessage{
    NSString *szRet = @"";
    if (dctRootJsonValue) {
        szRet = [dctRootJsonValue objectForKey:@"msg"];
    }
    return szRet;
}

- (NSDictionary*)getJsonByResultObject{
    if (dctRootJsonValue) {
        dctResultObject = [dctRootJsonValue objectForKey:@"data"];
        if ([dctResultObject isKindOfClass:[NSDictionary class]]) {
            return dctResultObject;
        }
    }
    return nil;
}

- (NSArray*)getJsonArrayByResultObject{
    if (dctRootJsonValue) {
        NSArray *array = [dctRootJsonValue objectForKey:@"data"];
        if ([array isKindOfClass:[NSArray class]]) {
            return array;
        }
    }
    return nil;
}

//必须是ResultObject内第一级数组
- (NSArray*)getJsonArray:(NSString *)szKey{
    if(dctResultObject){
        id array = [dctResultObject objectForKey:szKey];
        if ([array isKindOfClass:[NSArray class]]) {
            return array;
        }
    }
    return nil;
}

- (BOOL)isNSDictionary:(id)value{
    return [value isKindOfClass:[NSDictionary class]];
}



@end













































