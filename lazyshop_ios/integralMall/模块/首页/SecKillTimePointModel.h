//
//  SecKillTimePointModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface SecKillTimePointModel : BaseModel

@property (nonatomic,copy) NSString *sell_end_at;
@property (nonatomic,copy) NSString *sell_start_at;
@property (nonatomic,copy) NSString *time;

@end
