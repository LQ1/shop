//
//  DBHelper.m
//  DemoUI
//
//  Created by haitao liu on 14-7-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DBHelper.h"

static DBHelper *_shareObj = nil;

@implementation CodeName


@end

@implementation DBHelper
@synthesize sqliteDB;

+ (DBHelper*)sharedInstance{
    @synchronized(self){
        if(_shareObj == nil){
            _shareObj = [[self alloc] init];
        }
    }
    return _shareObj;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (_shareObj == nil) {
            _shareObj = [super allocWithZone:zone];
            return _shareObj;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone{
    return self;
}

+ (id)init{
    @synchronized(self){
        [super init];
        return self;
    }
}

//初始化数据库
+ (void)initDatabase{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *dbPath = [documents stringByAppendingPathComponent:DBNAME];
    //判断 数据库文件是否存在
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if(![fileMgr fileExistsAtPath:dbPath isDirectory:FALSE]){
        //isDBExist = YES;
        NSString *szDbResource = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DBNAME];
        [fileMgr copyItemAtPath:szDbResource toPath:dbPath error:&error];
    }
    //NSString *tmp = [documents stringByAppendingPathComponent:@"test.txt"];
    //NSFileHandle *fileHandler = [NSFileHandle file]
    sqlite3 *db3;
    if(sqlite3_open([dbPath UTF8String], &db3) != SQLITE_OK){
        sqlite3_close(db3);
        NSLog(@"打开数据库失败.");
    }
    else{
        [self sharedInstance].sqliteDB = db3;
        //[self createTable];
        
    }
}

//创建表
+ (void)createTable{
    
}

//执行SQL语句
+ (void)execSql:(NSString *)sql{
    char *err;
    if(sqlite3_exec([self sharedInstance].sqliteDB, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
        //sqlite3_close([self sharedInstance].sqliteDB);
        NSLog(@"执行SQL语句%@失败",sql);
    }
}

+ (sqlite3_stmt*)exeQuery:(NSString*)sql{
    sqlite3_stmt *stmt;
    sqlite3_prepare([self sharedInstance].sqliteDB, [sql UTF8String], -1, &stmt, NULL);
    return stmt;
}

//获取某表的ID
+ (int)getNewInsertID:(NSString *)szTableName withColumnName:(NSString *)szColumnName{
    int iRet = -1;
    NSString *sql = [NSString stringWithFormat:@"select max(%@) from %@",szColumnName,szTableName];
    sqlite3_stmt *stmt = [DBHelper exeQuery:sql];
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        iRet = sqlite3_column_int(stmt, 0);
    }
    sqlite3_finalize(stmt);
    return iRet;
}

//从数据库中获取字符串
+ (NSString*)getNSStringFromChar:(const unsigned char *)szText
{
    NSString *szContent = [NSString stringWithCString:(const char*)szText encoding:NSUTF8StringEncoding];
    return szContent;
}


+ (NSMutableArray*)queryCodeNames:(NSString *)szTableName withColCode:(int)nColCodeIndex withColName:(int)nColNameIndex{
    NSMutableArray *arrayCodes = [NSMutableArray new];
    NSString *szSql = [NSString stringWithFormat:@"select * from %@",szTableName];
    sqlite3_stmt *stmt = [DBHelper exeQuery:szSql];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        CodeName *cn = [[CodeName alloc] init];
        cn.szCode = [self getNSStringFromChar:sqlite3_column_text(stmt, nColCodeIndex)];
        cn.szName = [self getNSStringFromChar:sqlite3_column_text(stmt, nColNameIndex)];
        [arrayCodes addObject:cn];
    }
    sqlite3_finalize(stmt);
    return arrayCodes;
}

+ (NSMutableArray*)queryCodeNames:(NSString *)szTableName withColCode:(int)nColCodeIndex withColName:(int)nColNameIndex withWhere:(NSString*)szWhere{
    NSMutableArray *arrayCodes = [NSMutableArray new];
    NSString *szSql = [NSString stringWithFormat:@"select * from %@  %@",szTableName,szWhere];
    sqlite3_stmt *stmt = [DBHelper exeQuery:szSql];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        CodeName *cn = [[CodeName alloc] init];
        cn.szCode = [self getNSStringFromChar:sqlite3_column_text(stmt, nColCodeIndex)];
        cn.szName = [self getNSStringFromChar:sqlite3_column_text(stmt, nColNameIndex)];
        [arrayCodes addObject:cn];
    }
    sqlite3_finalize(stmt);
    return arrayCodes;
}


//由某一列代码查询名称
+ (NSString*)queryNameByCode:(NSString*)szTableName withColName:(NSString*)szColName withCode:(NSString*)szCode withColName:(int)nColNameIndex{
    NSString *szRet = @"";
    NSString *szSql = [NSString stringWithFormat:@"select * from %@ where %@ like '%@%%'",szTableName,szColName,szCode];
    sqlite3_stmt *stmt = [DBHelper exeQuery:szSql];
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        szRet = [self getNSStringFromChar:sqlite3_column_text(stmt, nColNameIndex)];
    }
    sqlite3_finalize(stmt);
    return szRet;
}

@end
















