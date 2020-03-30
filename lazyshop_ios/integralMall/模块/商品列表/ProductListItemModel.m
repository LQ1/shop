//
//  ProductListItemModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListItemModel.h"

@implementation ProductListItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    //对象名称在前，转换的数据在后
    return @{
             };
}

// 数字转字符串
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]&&![key isEqualToString:@"is_coupon"]) {
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
