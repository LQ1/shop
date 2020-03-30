//
//  DBServer.h
//  GovGenoffice
//
//  Created by xtkj on 15-4-23.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"

#define PN_UNAME @"LoginName"
#define PN_UPWN @"LoginPwd"
#define PN_REMEMBERPWD @"RememberPwd"
#define PN_AUTOLOGIN @"AutoLogin"
#define PN_FONTSIZE @"Fontsize"
#define PN_ISNOTFIRSTRUNAPP @"NoFirstRunApp"
#define PN_LASTESTQUERY @"LastestQuery"
#define PN_PUSH @"Push"
#define PN_SERVER @"server"
#define PN_LOCATION @"Location"


#define PV_YES @"Yes"
#define PV_NO @"NO"

@interface DBServer : NSObject

@end

//////////////
//参数表
//////////////
@interface DBParam : NSObject

+ (void)upldateParam:(NSString*)szParamName withIntValue:(int)nParamValue;

+ (void)upldateParamAdded:(NSString*)szParamName withAddedValue:(int)nValue;

+ (void)updateParam:(NSString*)szParamName withValue:(NSString*)szParamValue;

+ (NSString*)getParamValueByName:(NSString*)szParamName;

+ (BOOL)getIsRemember:(NSString*)szParamName;

+ (int)getNumValueByName:(NSString*)szParamName;


@end


@interface DBCodeName : NSObject

+ (NSMutableArray*)query_sallary;

+ (NSMutableArray*)query_WPLX;

+ (NSMutableArray*)query_LocalServer;

+ (NSMutableArray*)query_WP_JG;

+ (NSString*)query_sallary_CodeNameByCode:(NSString*)szCode;

+ (NSString*)query_PositionType_CodeNameByCode:(NSString*)szCode;

+ (NSString*)query_YearOfWork_CodeNameByCode:(NSString*)szCode;


@end











