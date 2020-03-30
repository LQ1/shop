//
//  ShippingAddressEidtViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressEidtViewModel.h"

#import "ShippingAddressModel.h"

#import "ShippingAddressService.h"

@interface ShippingAddressEidtViewModel()

@property (nonatomic,strong)ShippingAddressService *service;

@property (nonatomic,assign)BOOL isEidtAddress;

@property (nonatomic,copy )NSString *oriAddressUserName;
@property (nonatomic,copy )NSString *oriAddressPhoneNumber;
@property (nonatomic,copy )NSString *oriProvinceID;
@property (nonatomic,copy )NSString *oriCityID;
@property (nonatomic,copy )NSString *oriDistrictID;
@property (nonatomic,copy )NSString *oriAddressDetail;

@property (nonatomic,strong) NSArray * provinceDataSouce;
@property (nonatomic,strong) NSArray * cityDataSouce;
@property (nonatomic,strong) NSArray * districtDataSouce;

@property (nonatomic,strong)ShippingAddressModel *model;

@end

@implementation ShippingAddressEidtViewModel

- (instancetype)initWithShippingAddressModel:(ShippingAddressModel *)model
{
    self = [super init];
    if (self) {
        self.service = [ShippingAddressService new];
        
        self.model = model;
        
        self.isEidtAddress = YES;
        
        self.addressID = [model.user_address_id lyStringValue];
        self.adressAreaName = [[model.province_name stringByAppendingString:model.city_name] stringByAppendingString:model.district_name];
        
        self.addressUserName = model.receiver;
        self.addressPhoneNumber = model.receiver_mobile;
        self.province_id = [model.province_id lyStringValue];
        self.city_id = [model.city_id lyStringValue];
        self.district_id = [model.district_id lyStringValue];
        self.addressDetail = model.address_detail;

        [self mapOrignalAddress];
    }
    return self;
}

- (void)mapOrignalAddress
{
    self.oriAddressUserName = self.addressUserName;
    self.oriAddressPhoneNumber = self.addressPhoneNumber;
    self.oriProvinceID = self.province_id;
    self.oriCityID = self.city_id;
    self.oriDistrictID = self.district_id;
    self.oriAddressDetail = self.addressDetail;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [ShippingAddressService new];
    }
    return self;
}

- (void)getData
{
    [self.fetchListSuccessSignal sendNext:nil];
}

- (NSString *)fetchNavTitle
{
    if (self.isEidtAddress) {
        return @"编辑收货地址";
    }else{
        return @"新建收货地址";
    }
}

- (void)savaAddress
{
    if (!self.addressUserName.length) {
        [self.tipLoadingSignal sendNext:@"请输入收货人姓名"];
        return;
    }
    if (!self.addressPhoneNumber.length) {
        [self.tipLoadingSignal sendNext:@"请输入收货人联系方式"];
        return;
    }
    if (!self.province_id.length||!self.city_id.length||!self.district_id.length) {
        [self.tipLoadingSignal sendNext:@"请选择所在地区"];
        return;
    }
    if (!self.addressDetail.length) {
        [self.tipLoadingSignal sendNext:@"请输入详细收货地址"];
        return;
    }
    
    // 保存收货地址
    @weakify(self);
    self.loading = YES;
    
    RACSignal *signal = nil;
    if (self.isEidtAddress) {
        signal = [self.service updateAddressListWithUser_address_id:[self.addressID integerValue]
                                                        province_id:[self.province_id integerValue]
                                                            city_id:[self.city_id integerValue]
                                                        district_id:[self.district_id integerValue]
                                                           receiver:self.addressUserName
                                                    receiver_mobile:self.addressPhoneNumber
                                                     address_detail:self.addressDetail];
    }else{
        signal = [self.service addAddressListWithProvince_id:[self.province_id integerValue]
                                                     city_id:[self.city_id integerValue]
                                                 district_id:[self.district_id integerValue]
                                                    receiver:self.addressUserName
                                             receiver_mobile:self.addressPhoneNumber
                                              address_detail:self.addressDetail];
    }
    
    RACDisposable *disPos = [signal subscribeNext:^(id x) {
        @strongify(self);
        [self mapOrignalAddress];
        [self.tipLoadingSignal sendNext:@"保存成功"];
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -是否需要提示保存
- (BOOL)needWarningToSave
{
    BOOL allText = self.addressUserName.length&&
                self.addressPhoneNumber.length&&
                       self.province_id.length&&
                           self.city_id.length&&
                       self.district_id.length&&
                     self.addressDetail.length;
    
    BOOL hasChange = ![self.addressUserName isEqualToString:self.oriAddressUserName]||
                     ![self.addressPhoneNumber isEqualToString:self.oriAddressPhoneNumber]||
                     ![self.province_id isEqualToString:self.oriProvinceID]||
                     ![self.city_id isEqualToString:self.oriCityID]||
                     ![self.district_id isEqualToString:self.oriDistrictID]||
                     ![self.addressDetail isEqualToString:self.oriAddressDetail];
    
    if (allText&&hasChange) {
        return YES;
    }
    return NO;
}

#pragma mark -是否已选择地区
- (BOOL)hasSelectArea
{
    if (self.province_id.length&&self.city_id.length&&self.district_id.length) {
        return YES;
    }
    return NO;
}

#pragma mark -获取地区信息
// 获取省份
- (RACSignal *)fetchProvinceDataSource
{
    @weakify(self);
    [DLLoading DLLoadingInWindow:@"获取省份信息中" close:nil];
    return [[[self.service fetchAddressProvince] catch:^RACSignal *(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
        return [RACSignal error:error];
    }] map:^id(id value) {
        @strongify(self);
        self.provinceDataSouce = [NSArray arrayWithArray:value];
        [DLLoading DLHideInWindow];
        return value;
    }];
}
// 获取城市
- (RACSignal *)fetchCityDataSourceWithProvinceID:(NSString *)provinceID
{
    @weakify(self);
    [DLLoading DLLoadingInWindow:@"获取城市信息中" close:nil];
    return [[[self.service fetchAddressCityWithProvince_id:provinceID] catch:^RACSignal *(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
        return [RACSignal error:error];
    }] map:^id(id value) {
        @strongify(self);
        self.cityDataSouce = [NSArray arrayWithArray:value];
        [DLLoading DLHideInWindow];
        return value;
    }];
}
// 获取区县
- (RACSignal *)fetchDistrictDataSourceWithCityID:(NSString *)cityID
{
    @weakify(self);
    [DLLoading DLLoadingInWindow:@"获取区县信息中" close:nil];
    return [[[self.service fetchAddressDistrictWithCity_id:cityID] catch:^RACSignal *(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
        return [RACSignal error:error];
    }] map:^id(id value) {
        @strongify(self);
        self.districtDataSouce = [NSArray arrayWithArray:value];
        [DLLoading DLHideInWindow];
        return value;
    }];
}

@end
