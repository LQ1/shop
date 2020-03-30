//
//  AddressDistrictModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface AddressDistrictModel : BaseStringProModel

@property (nonatomic, copy) NSString *district_name;
@property (nonatomic, copy) NSString *district_id;
@property (nonatomic, assign) BOOL isSelected;

@end
