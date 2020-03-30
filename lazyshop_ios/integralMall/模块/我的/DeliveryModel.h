//
//  DeliveryModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "DeliveryTrackModel.h"

@interface DeliveryModel : BaseStringProModel

@property (nonatomic,copy) NSString *delivery_no;
@property (nonatomic,copy) NSString *delivery_name;
@property (nonatomic,strong) NSArray *traces;

@end
