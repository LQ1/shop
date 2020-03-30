//
//  ShippingAddressService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShippingAddressService : NSObject

/*
 *  增加收货地址
 */
- (RACSignal *)addAddressListWithProvince_id:(NSInteger)province_id
                                     city_id:(NSInteger)city_id
                                 district_id:(NSInteger)district_id
                                    receiver:(NSString *)receiver
                             receiver_mobile:(NSString *)receiver_mobile
                              address_detail:(NSString *)address_detail;
/*
 *  删除收货地址
 */
- (RACSignal *)deleleAddressListWithUser_address_id:(NSInteger)user_address_id;
/*
 *  更新收货地址
 */
- (RACSignal *)updateAddressListWithUser_address_id:(NSInteger)user_address_id
                                        province_id:(NSInteger)province_id
                                            city_id:(NSInteger)city_id
                                        district_id:(NSInteger)district_id
                                           receiver:(NSString *)receiver
                                    receiver_mobile:(NSString *)receiver_mobile
                                     address_detail:(NSString *)address_detail;
/*
 *  获取收货地址
 */
- (RACSignal *)getAddressList;
/*
 *  设置默认收货地址
 */
- (RACSignal *)setDefaulAddressWithUser_address_id:(NSInteger)user_address_id;

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
