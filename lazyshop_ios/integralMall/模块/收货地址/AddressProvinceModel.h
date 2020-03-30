//
//  AddressProvinceModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface AddressProvinceModel : BaseStringProModel

@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, strong) NSArray *cityList;
@property (nonatomic, assign) BOOL isSelected;

@end
