//
//  ShippingAddressManageCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressItemBaseCell.h"

#define ShippingAddressManageCellHeight 135.0f

typedef NS_ENUM(NSInteger,ShippingAddressManageCellClickType)
{
    ShippingAddressManageCellClickType_SetDefault = 0,
    ShippingAddressManageCellClickType_Edit,
    ShippingAddressManageCellClickType_Delete
};

@interface ShippingAddressManageCell : ShippingAddressItemBaseCell

@property (nonatomic,readonly)RACSubject *clickSignal;

@end
