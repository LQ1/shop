//
//  AddressCityModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface AddressCityModel : BaseStringProModel

@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, strong) NSArray *districtList;
@property (nonatomic, assign) BOOL isSelected;

@end
