//
//  UserInfoModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    //对象名称在前，转换的数据在后
    return @{
             };
}

#pragma mark - LKDBHelper

+ (NSString *)getTableName
{
    return @"User";
}

+ (NSString *)getPrimaryKey
{
    return @"mobilePhone";
}

#pragma mark - DB Mapping

//! 数据库字段映射，key为数据库字段，value为属性
+ (NSDictionary *)tableMapping
{
    return @{
             @"mobilePhone":@"mobilePhone",
             @"token":@"token",
             @"lastLoginTime":@"lastLoginTime"
             };
}

#pragma mark -性别名称
- (NSString *)sexName
{
    switch (self.sex) {
        case UserSexType_UnKnown:
        {
            return @"保密";
        }
            break;
        case UserSexType_Man:
        {
            return @"男";
        }
            break;
        case UserSexType_Woman:
        {
            return @"女";
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}

#pragma mark -会员信息

- (NSString *)vipLevelNameWithLevel:(UserVipLevel)level
{
    switch (level) {
        case UserVipLevel_Regis:
        {
            return @"注册会员";
        }
            break;
        case UserVipLevel_Tong:
        {
            return @"铜牌会员";
        }
            break;
        case UserVipLevel_Yin:
        {
            return @"银牌会员";
        }
            break;
        case UserVipLevel_Jin:
        {
            return @"金牌会员";
        }
            break;
        case UserVipLevel_Zuan:
        {
            return @"钻石会员";
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)vipLevelName
{
    return [self vipLevelNameWithLevel:self.vipLevel];
}

- (NSString *)vipLevelImageName
{
    switch (self.vipLevel) {
        case UserVipLevel_Regis:
        {
            return @"注";
        }
            break;
        case UserVipLevel_Tong:
        {
            return @"铜";
        }
            break;
        case UserVipLevel_Yin:
        {
            return @"银";
        }
            break;
        case UserVipLevel_Jin:
        {
            return @"金";
        }
            break;
        case UserVipLevel_Zuan:
        {
            return @"钻";
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}


#pragma mark -token
- (NSString *)token
{
    if (_token.length) {
        return _token;
    }
    return @"";
}

@end
