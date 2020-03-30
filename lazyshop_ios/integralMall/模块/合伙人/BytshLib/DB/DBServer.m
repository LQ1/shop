//
//  DBServer.m
//  GovGenoffice
//
//  Created by xtkj on 15-4-23.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//

#import "DBServer.h"
#import "DBHelper.h"

@implementation DBServer

@end

//////////////////////////
@implementation DBParam


+ (void)upldateParam:(NSString *)szParamName withIntValue:(int)nParamValue{
    NSString *szParamValue = [NSString stringWithFormat:@"%d",nParamValue];
    [self updateParam:szParamName withValue:szParamValue];
}

//累加更新数值
+ (void)upldateParamAdded:(NSString *)szParamName withAddedValue:(int)nValue{
    int nNum = [self getNumValueByName:szParamName];
    nNum += nValue;
    [self upldateParam:szParamName withIntValue:nNum];
}

//更新参数表，包括新插入数据
+ (void)updateParam:(NSString *)szParamName withValue:(NSString *)szParamValue
{
    int iRet = 0;
    NSString *szSql = [NSString stringWithFormat:@"select count(*) from SystemParam where ParamName='%@'",szParamName];
    sqlite3_stmt *stmt = [DBHelper exeQuery:szSql];
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        iRet = sqlite3_column_int(stmt, 0);
    }
    sqlite3_finalize(stmt);
    
    if (iRet >0) {
        szSql = [NSString stringWithFormat:@"update SystemParam set ParamValue='%@' where ParamName='%@'",szParamValue,szParamName];
    }else{
        szSql = [NSString stringWithFormat:@"insert into SystemParam values('%@','%@')",szParamName,szParamValue];
    }
    
    [DBHelper execSql:szSql];
}

//由参数获取值
+ (NSString*)getParamValueByName:(NSString *)szParamName
{
    NSString *szRetValue = @"";
    NSString *szSql = [NSString stringWithFormat:@"select * from SystemParam where ParamName='%@'",szParamName];
    sqlite3_stmt *stmt = [DBHelper exeQuery:szSql];
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        szRetValue = [NSString stringWithCString:(char*)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding];
    }
    sqlite3_finalize(stmt);
    return szRetValue;
}

+ (BOOL)getIsRemember:(NSString *)szParamName{
    NSString *szValue = [self getParamValueByName:szParamName];
    return [szValue isEqualToString:PV_YES];
}

+ (int)getNumValueByName:(NSString *)szParamName{
    NSString *szValue = [self getParamValueByName:szParamName];
    return [szValue intValue];
}

@end


@implementation DBCodeName

+ (NSMutableArray*)query_sallary{
    return [DBHelper queryCodeNames:@"SalaryLevel" withColCode:1 withColName:2];
}

+ (NSMutableArray*)query_WPLX{
    return [DBHelper queryCodeNames:@"SecondHandType" withColCode:1 withColName:2];
}

+ (NSMutableArray*)query_LocalServer{
    return [DBHelper queryCodeNames:@"LifeServer" withColCode:1 withColName:2];
}

+ (NSMutableArray*)query_WP_JG{
    return [DBHelper queryCodeNames:@"GoodsPriceRange" withColCode:1 withColName:2];
}

+ (NSString*)query_sallary_CodeNameByCode:(NSString*)szCode{
    return [DBHelper queryNameByCode:@"SalaryLevel" withColName:@"Code" withCode:szCode withColName:2];
}

+ (NSString*)query_PositionType_CodeNameByCode:(NSString*)szCode{
    return [DBHelper queryNameByCode:@"PositionType" withColName:@"PositionCode" withCode:szCode withColName:2];
}

+ (NSString*)query_YearOfWork_CodeNameByCode:(NSString*)szCode{
    return [DBHelper queryNameByCode:@"YearOfWork" withColName:@"Code" withCode:szCode withColName:2];
}

@end
















