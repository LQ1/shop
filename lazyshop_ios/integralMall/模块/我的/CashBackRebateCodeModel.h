//
//  CashBackRebateCodeModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface CashBackRebateCodeModel : BaseStringProModel

@property (nonatomic,copy) NSString *can_use;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *rebate_period;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *is_current;
@property (nonatomic,copy) NSString *use_at;
@property (nonatomic,copy) NSString *can_use_at;

@end
