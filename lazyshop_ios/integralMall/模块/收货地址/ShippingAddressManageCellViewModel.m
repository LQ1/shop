//
//  ShippingAddressManageCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressManageCellViewModel.h"

#import "ShippingAddressModel.h"

@interface ShippingAddressManageCellViewModel()

@end

@implementation ShippingAddressManageCellViewModel

- (instancetype)initWithShippingAddressModel:(ShippingAddressModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        
        self.isDefault = [model.defaultAddress boolValue];
        self.shippingAddressID = [model.user_address_id lyStringValue];
        self.shippingPhoneNumber = model.receiver_mobile;
        self.shippingUserName = model.receiver;
        self.shippingAddress = model.full_address;
    }
    return self;
}

@end
