//
//  SecKillTimeModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

#import "SecKillTimePointModel.h"

@interface SecKillTimeModel : BaseModel

@property (nonatomic,strong) NSArray *time_slice;
@property (nonatomic,copy) NSString *current_at;

@end
