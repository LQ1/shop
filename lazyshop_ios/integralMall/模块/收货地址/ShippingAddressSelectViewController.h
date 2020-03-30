//
//  ShippingAddressSelectViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYNavigationBarViewController.h"

#import "ShippingAddressModel.h"

typedef void (^AddressSelectSuccessBlock)(ShippingAddressModel *addressModel);

@interface ShippingAddressSelectViewController : LYNavigationBarViewController

@property (nonatomic,copy) AddressSelectSuccessBlock selectSuccessBlock;

@end
