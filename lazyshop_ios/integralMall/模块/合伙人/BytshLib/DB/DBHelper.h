//
//  DBHelper.h
//  DemoUI
//
//  Created by haitao liu on 14-7-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#define DBNAME @"base.sqlite"


@interface CodeName : NSObject

@property NSString *szCode;
@property NSString *szName;
@property NSObject *obj;

@end


//定义列所在数据库的位置


@interface DBHelper : NSObject

@property(nonatomic)sqlite3 *sqliteDB;


+ (DBHelper*)sharedInstance;

+ (void)initDatabase;

+ (void)createTable;

+ (void)execSql:(NSString*)sql;

+ (sqlite3_stmt*)exeQuery:(NSString*)sql;

+ (int)getNewInsertID:(NSString*)szTableName withColumnName:(NSString*)szColumnName;

+ (NSString*)getNSStringFromChar:(const unsigned char*)szText;

//查询代码表
+ (NSMutableArray*)queryCodeNames:(NSString *)szTableName withColCode:(int)nColCodeIndex withColName:(int)nColNameIndex;

+ (NSMutableArray*)queryCodeNames:(NSString *)szTableName withColCode:(int)nColCodeIndex withColName:(int)nColNameIndex withWhere:(NSString*)szWhere;

+ (NSString*)queryNameByCode:(NSString*)szTableName withColName:(NSString*)szColName withCode:(NSString*)szCode withColName:(int)nColNameIndex;

@end

