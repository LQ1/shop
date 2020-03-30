//
//  ShippingAddressItemBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ShippingAddressItemBaseViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *shippingAddressID;
@property (nonatomic,copy) NSString *shippingUserName;
@property (nonatomic,copy) NSString *shippingPhoneNumber;
@property (nonatomic,copy) NSString *shippingAddress;

@end
