//
//  DeliveryTrackModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface DeliveryTrackModel : BaseStringProModel

@property (nonatomic,copy) NSString *accept_time;
@property (nonatomic,copy) NSString *accept_station;
@property (nonatomic,copy) NSString *remark;

@end
