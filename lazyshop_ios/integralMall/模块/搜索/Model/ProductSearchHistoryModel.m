//
//  ProductSearchHistoryModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchHistoryModel.h"

@implementation ProductSearchHistoryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    //对象名称在前，转换的数据在后
    return @{
             };
}

#pragma mark - LKDBHelper

+ (NSString *)getTableName
{
    return @"ProductSearchHistory";
}

+ (NSString *)getPrimaryKey
{
    return @"_id";
}

#pragma mark - DB Mapping

//! 数据库字段映射，key为数据库字段，value为属性
+ (NSDictionary *)tableMapping
{
    return @{
                @"_id":@"_id",
                @"searchKeyword":@"searchKeyword"
             };
}



@end
