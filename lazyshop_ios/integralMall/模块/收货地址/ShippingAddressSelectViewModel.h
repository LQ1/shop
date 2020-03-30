//
//  ShippingAddressSelectViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger, ShippingAddressSelectViewModel_Signal_Type)
{
    ShippingAddressSelectViewModel_Signal_Type_ReloadData,
    ShippingAddressSelectViewModel_Signal_Type_SelectAddressSuccess,
    ShippingAddressSelectViewModel_Signal_Type_GotoAddAddress
};

@interface ShippingAddressSelectViewModel : LYBaseViewModel

- (instancetype)initWithUserAddressID:(NSString *)userAddressID;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addAddress;

@end
