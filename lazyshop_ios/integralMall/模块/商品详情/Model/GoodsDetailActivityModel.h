//
//  GoodsDetailActivityModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface GoodsDetailActivityModel : BaseStringProModel

@property (nonatomic,copy) NSString *activity_type;
@property (nonatomic,copy) NSString *sell_end_at;
@property (nonatomic,copy) NSString *activity_group_id;
@property (nonatomic,copy) NSString *missing_num;

@end
