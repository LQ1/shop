//
//  BaseService.h
//  HomeDecoration
//
//  Created by xtkj on 15/6/12.
//  Copyright (c) 2015年 anz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpHelper.h"
#import "GlobalSetting.h"
#import "DBServer.h"
#import "EntityJson.h"

@interface BaseViewModel1 : NSObject{
    NSMutableDictionary *dictParams;
    
    NSDictionary *dctRootJsonValue;
    NSDictionary *dctResultObject;
}

@property NSString *ERROR_MSG;

- (id)init;

- (void)initArrayParams:(NSString*)szKeyTag;
- (void)addParams:(NSString*)szKeyTag withKey:(NSString*)szKey withStringValue:(NSString*)szValue;
- (void)addParams:(NSString*)szTagKey withDictionary:(NSDictionary*)dictionary;
- (void)addParams:(NSString*)szKeyTag withKey:(NSString *)szKey withIntValue:(int)nValue;
- (void)addParams:(NSString*)szKeyTag withKey:(NSString *)szKey withLongValue:(long)nValue;
- (void)addParams:(NSString*)szKeyTag withKey:(NSString*)szKey withDoubleValue:(CGFloat)dValue;
- (void)addParamsPageNum:(NSString*)szKeyTag withNum:(int)nPageNum;
- (void)addParamsId:(NSString*)szKeyTag withId:(int)nId;

- (NSString*)getSingleValueByResultObject;
- (int)getIntValueByResult;
- (BOOL)getDataFromService:(NSString*)szKeyTag withPage:(NSString*)szPageName;
- (BOOL)getDataFromService_GET:(NSString*)szKeyTag withPage:(NSString*)szPageName;
- (NSData*)getDataFromService_GET_1:(NSString*)szKeyTag withPage:(NSString*)szPageName;
//- (SimpleReturn*)getDataFromService:(NSString*)szPageName;
- (BOOL)isOk:(NSData*)dataResult;
- (NSDictionary*)getJsonByResultObject;
- (NSArray*)getJsonArray:(NSString*)szKey;
- (NSArray*)getJsonArrayByResultObject;

- (BOOL)isNSDictionary:(id)value;

@end
