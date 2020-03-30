//
//  ShippingAddressSelectCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressSelectCellViewModel.h"

#import "ShippingAddressModel.h"

@implementation ShippingAddressSelectCellViewModel

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
