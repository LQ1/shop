//
//  ShippingAddressSelectCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressItemBaseViewModel.h"

@class ShippingAddressModel;

@interface ShippingAddressSelectCellViewModel : ShippingAddressItemBaseViewModel

@property (nonatomic,strong)ShippingAddressModel *model;

@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL isDefault;

- (instancetype)initWithShippingAddressModel:(ShippingAddressModel *)model;

@end
