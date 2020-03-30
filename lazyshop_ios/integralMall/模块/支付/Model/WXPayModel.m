//
//  WXPayModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "WXPayModel.h"

@implementation WXPayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    //对象名称在前，转换的数据在后
    return @{
             @"package":@"package_value"
             };
}

//#pragma mark - LKDBHelper
//
//+ (NSString *)getTableName
//{
//    return nil;
//}
//
//+ (NSString *)getPrimaryKey
//{
//    return @"_id";
//}
//
//#pragma mark - DB Mapping
//
////! 数据库字段映射，key为数据库字段，value为属性
//+ (NSDictionary *)tableMapping
//{
//    return @{
//
//             };
//}


@end
