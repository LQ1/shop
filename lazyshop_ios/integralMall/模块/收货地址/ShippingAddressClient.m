//
//  ShippingAddressClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressClient.h"

#define API_GET_ADDRESS_ADD     @"http://"APP_DOMAIN@"/useraddress/add"
#define API_GET_ADDRESS_DELETE  @"http://"APP_DOMAIN@"/useraddress/delete"
#define API_GET_ADDRESS_UPDATE  @"http://"APP_DOMAIN@"/useraddress/update"
#define API_GET_ADDRESS_LIST    @"http://"APP_DOMAIN@"/useraddress/list"
#define API_GET_ADDRESS_DEFAULT @"http://"APP_DOMAIN@"/useraddress/setdefault"

#define API_GET_ADDRESS_PROVINCE  @"http://"APP_DOMAIN@"/address/province"
#define API_GET_ADDRESS_CITY      @"http://"APP_DOMAIN@"/address/city"
#define API_GET_ADDRESS_DISTRICT  @"http://"APP_DOMAIN@"/address/district"

@implementation ShippingAddressClient

#pragma mark -增加收货地址
- (RACSignal *)addAddressListWithToken:(NSString *)token
                           province_id:(NSInteger)province_id
                               city_id:(NSInteger)city_id
                           district_id:(NSInteger)district_id
                              receiver:(NSString *)receiver
                       receiver_mobile:(NSString *)receiver_mobile
                        address_detail:(NSString *)address_detail
{
    token = token ?:@"";
    receiver = receiver ?:@"";
    receiver_mobile = receiver_mobile ?:@"";
    address_detail = address_detail ?:@"";
    
    NSDictionary *prams = @{
                            @"token":token,
                            @"province_id":@(province_id),
                            @"city_id":@(city_id),
                            @"district_id":@(district_id),
                            @"receiver":receiver,
                            @"receiver_mobile":receiver_mobile,
                            @"address_detail":address_detail
                            };
    
    return [LYHttpHelper POST:API_GET_ADDRESS_ADD params:prams dealCode:YES];
}

#pragma mark -删除收货地址
- (RACSignal *)deleleAddressListWithToken:(NSString *)token
                          user_address_id:(NSInteger)user_address_id
{
    token = token ?:@"";
    
    NSDictionary *prams = @{
                            @"token":token,
                            @"user_address_id":@(user_address_id)
                            };
    
    return [LYHttpHelper POST:API_GET_ADDRESS_DELETE params:prams dealCode:YES];
}

#pragma mark -更新收货地址
- (RACSignal *)updateAddressListWithToken:(NSString *)token
                          user_address_id:(NSInteger)user_address_id
                              province_id:(NSInteger)province_id
                                  city_id:(NSInteger)city_id
                              district_id:(NSInteger)district_id
                                 receiver:(NSString *)receiver
                          receiver_mobile:(NSString *)receiver_mobile
                           address_detail:(NSString *)address_detail
{
    token = token ?:@"";
    
    NSDictionary *prams = @{
                            @"token":token,
                            @"user_address_id":@(user_address_id),
                            @"province_id":@(province_id),
                            @"city_id":@(city_id),
                            @"district_id":@(district_id),
                            @"receiver":receiver,
                            @"receiver_mobile":receiver_mobile,
                            @"address_detail":address_detail
                            };
    
    return [LYHttpHelper POST:API_GET_ADDRESS_UPDATE params:prams dealCode:YES];
}

#pragma mark -获取收货地址
- (RACSignal *)getAddressListWithToken:(NSString *)token
{
    token = token ?:@"";
    
    NSDictionary *prams = @{@"token":token};
    return [LYHttpHelper GET:API_GET_ADDRESS_LIST params:prams dealCode:YES];
}

#pragma mark -设置默认收货地址
- (RACSignal *)setDefaulAddressWithToken:(NSString *)token
                         user_address_id:(NSInteger)user_address_id
{
    token = token ?:@"";
    
    NSDictionary *prams = @{
                            @"token":token,
                            @"user_address_id":@(user_address_id)
                            };
    
    return [LYHttpHelper POST:API_GET_ADDRESS_DEFAULT params:prams dealCode:YES];
}

#pragma mark -省份
- (RACSignal *)fetchAddressProvince
{
    return [LYHttpHelper GET:API_GET_ADDRESS_PROVINCE params:nil dealCode:YES];
}

#pragma mark -城市
- (RACSignal *)fetchAddressCityWithProvince_id:(NSString *)province_id
{
    NSDictionary *prams = @{
                            @"province_id":province_id
                            };

    return [LYHttpHelper GET:API_GET_ADDRESS_CITY params:prams dealCode:YES];
}

#pragma mark -区县
- (RACSignal *)fetchAddressDistrictWithCity_id:(NSString *)city_id
{
    NSDictionary *prams = @{
                            @"city_id":city_id
                            };
    
    return [LYHttpHelper GET:API_GET_ADDRESS_DISTRICT params:prams dealCode:YES];
}

@end
