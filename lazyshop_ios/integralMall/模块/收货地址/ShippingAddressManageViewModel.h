//
//  ShippingAddressManageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,ShippingAddressManageViewModel_Singal_Type)
{
    ShippingAddressManageViewModel_Singal_Type_GotoAddAddress = 0,
    ShippingAddressManageViewModel_Singal_Type_GetData
};

@interface ShippingAddressManageViewModel : LYBaseViewModel

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)setDefaultAtRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)editAtRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteAtRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addAddress;

@end
