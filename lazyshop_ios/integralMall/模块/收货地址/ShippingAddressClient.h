//
//  ShippingAddressClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShippingAddressClient : NSObject

/*
 *  增加收货地址
 */
- (RACSignal *)addAddressListWithToken:(NSString *)token
                           province_id:(NSInteger)province_id
                               city_id:(NSInteger)city_id
                           district_id:(NSInteger)district_id
                              receiver:(NSString *)receiver
                       receiver_mobile:(NSString *)receiver_mobile
                        address_detail:(NSString *)address_detail;
/*
 *  删除收货地址
 */
- (RACSignal *)deleleAddressListWithToken:(NSString *)token
                          user_address_id:(NSInteger)user_address_id;
/*
 *  更新收货地址
 */
- (RACSignal *)updateAddressListWithToken:(NSString *)token
                          user_address_id:(NSInteger)user_address_id
                              province_id:(NSInteger)province_id
                                  city_id:(NSInteger)city_id
                              district_id:(NSInteger)district_id
                                 receiver:(NSString *)receiver
                          receiver_mobile:(NSString *)receiver_mobile
                           address_detail:(NSString *)address_detail;
/*
 *  获取收货地址
 */
- (RACSignal *)getAddressListWithToken:(NSString *)token;
/*
 *  设置默认收货地址
 */
- (RACSignal *)setDefaulAddressWithToken:(NSString *)token
                         user_address_id:(NSInteger)user_address_id;

/*
 *  获取省份
 */
- (RACSignal *)fetchAddressProvince;
/*
 *  获取城市
 */
- (RACSignal *)fetchAddressCityWithProvince_id:(NSString *)province_id;
/*
 *  获取区县
 */
- (RACSignal *)fetchAddressDistrictWithCity_id:(NSString *)city_id;

@end
