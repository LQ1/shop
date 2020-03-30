//
//  CashBackHistoryModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface CashBackHistoryModel : BaseStringProModel

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *use_type;
@property (nonatomic,copy) NSString *rebate_period;
@property (nonatomic,copy) NSString *user_money;
@property (nonatomic,copy) NSString *use_at;

@end
