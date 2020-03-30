//
//  ShippingAddressModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/11.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ShippingAddressModel : BaseStringProModel

@property (nonatomic,copy) NSString *user_address_id;
@property (nonatomic,copy) NSString *province_id;
@property (nonatomic,copy) NSString *province_name;
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *district_id;
@property (nonatomic,copy) NSString *district_name;
@property (nonatomic,copy) NSString *address_detail;
@property (nonatomic,copy) NSString *receiver;
@property (nonatomic,copy) NSString *receiver_mobile;
@property (nonatomic,copy) NSString *full_address;
@property (nonatomic,copy) NSString *defaultAddress;


@end
