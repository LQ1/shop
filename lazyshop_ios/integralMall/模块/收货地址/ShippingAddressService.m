//
//  ShippingAddressService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressService.h"

#import "ShippingAddressClient.h"

#import "ShippingAddressModel.h"

#import "AddressProvinceModel.h"
#import "AddressCityModel.h"
#import "AddressDistrictModel.h"

@interface ShippingAddressService()

@property (nonatomic,strong)ShippingAddressClient *client;

@end

@implementation ShippingAddressService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [ShippingAddressClient new];
    }
    return self;
}

#pragma mark -新增收货地址
- (RACSignal *)addAddressListWithProvince_id:(NSInteger)province_id
                                     city_id:(NSInteger)city_id
                                 district_id:(NSInteger)district_id
                                    receiver:(NSString *)receiver
                             receiver_mobile:(NSString *)receiver_mobile
                              address_detail:(NSString *)address_detail
{
    return [[self.client addAddressListWithToken:SignInToken
                                    province_id:province_id
                                        city_id:city_id
                                    district_id:district_id
                                       receiver:receiver
                                receiver_mobile:receiver_mobile
                                 address_detail:address_detail] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -删除收货地址
- (RACSignal *)deleleAddressListWithUser_address_id:(NSInteger)user_address_id
{
    return [[self.client deleleAddressListWithToken:SignInToken
                                   user_address_id:user_address_id] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -修改收货地址
- (RACSignal *)updateAddressListWithUser_address_id:(NSInteger)user_address_id
                                        province_id:(NSInteger)province_id
                                            city_id:(NSInteger)city_id
                                        district_id:(NSInteger)district_id
                                           receiver:(NSString *)receiver
                                    receiver_mobile:(NSString *)receiver_mobile
                                     address_detail:(NSString *)address_detail
{
    return [[self.client updateAddressListWithToken:SignInToken
                                   user_address_id:user_address_id
                                       province_id:province_id
                                           city_id:city_id
                                       district_id:district_id
                                          receiver:receiver
                                   receiver_mobile:receiver_mobile
                                    address_detail:address_detail] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -获取收货地址
- (RACSignal *)getAddressList
{
    return [[self.client getAddressListWithToken:SignInToken] tryMap:^id(NSDictionary *dict, NSError *__autoreleasing *errorPtr) {
        NSArray *resultArray = [ShippingAddressModel modelsFromJSONArray:dict[@"data"]];
        if (!resultArray.count) {
            *errorPtr = AppErrorEmptySetting(@"收货地址列表为空");
            return nil;
        }
        return resultArray;
    }];
}

#pragma mark -设置默认地址
- (RACSignal *)setDefaulAddressWithUser_address_id:(NSInteger)user_address_id
{
    return [[self.client setDefaulAddressWithToken:SignInToken
                                  user_address_id:user_address_id] map:^id(id value) {
        return @(YES);
    }];
}

#pragma mark -获取地址地区
/*
 *  获取省份
 */
- (RACSignal *)fetchAddressProvince
{
    return [[self.client fetchAddressProvince] map:^id(NSDictionary *dict) {
        NSArray *resultArray = [AddressProvinceModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}
/*
 *  获取城市
 */
- (RACSignal *)fetchAddressCityWithProvince_id:(NSString *)province_id
{
    return [[self.client fetchAddressCityWithProvince_id:province_id] map:^id(NSDictionary *dict) {
        NSArray *resultArray = [AddressCityModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}
/*
 *  获取区县
 */
- (RACSignal *)fetchAddressDistrictWithCity_id:(NSString *)city_id
{
    return [[self.client fetchAddressDistrictWithCity_id:city_id] map:^id(NSDictionary *dict) {
        NSArray *resultArray = [AddressDistrictModel modelsFromJSONArray:dict[@"data"]];
        return resultArray;
    }];
}

@end
