//
//  ShippingAddressEidtViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@class ShippingAddressModel;

@interface ShippingAddressEidtViewModel : LYBaseViewModel

@property (nonatomic,copy )NSString *addressID;
@property (nonatomic,copy )NSString *addressUserName;
@property (nonatomic,copy )NSString *addressPhoneNumber;
@property (nonatomic,copy )NSString *province_id;
@property (nonatomic,copy )NSString *city_id;
@property (nonatomic,copy )NSString *district_id;
@property (nonatomic,copy )NSString *adressAreaName;
@property (nonatomic,copy )NSString *addressDetail;

@property (nonatomic,readonly) NSArray * provinceDataSouce;
@property (nonatomic,readonly) NSArray * cityDataSouce;
@property (nonatomic,readonly) NSArray * districtDataSouce;

- (instancetype)initWithShippingAddressModel:(ShippingAddressModel *)model;

- (NSString *)fetchNavTitle;

- (void)savaAddress;

- (BOOL)needWarningToSave;

- (BOOL)hasSelectArea;

// 获取省份
- (RACSignal *)fetchProvinceDataSource;
// 获取城市
- (RACSignal *)fetchCityDataSourceWithProvinceID:(NSString *)provinceID;
// 获取区县
- (RACSignal *)fetchDistrictDataSourceWithCityID:(NSString *)cityID;

@end
