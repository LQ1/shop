//
//  CategoryModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    //对象名称在前，转换的数据在后
    return @{
             };
}

// 数字转字符串
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]&&![key isEqualToString:@"goods_cat_id"]) {
        value = [value stringValue];
    }
    [super setValue:value forKey:key];
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
