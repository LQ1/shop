//
//  CashBackModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "CashBackRebateCodeModel.h"

@interface CashBackModel : BaseStringProModel

@property (nonatomic,copy) NSString *goods_title;
@property (nonatomic,copy) NSString *shop_id;
@property (nonatomic,copy) NSString *shop_name;
@property (nonatomic,copy) NSString *storehouse_id;
@property (nonatomic,copy) NSString *storehouse_name;
@property (nonatomic,copy) NSString *order_detail_id;
@property (nonatomic,copy) NSString *order_id;

@property (nonatomic,copy) NSString *rebate_days;

@property (nonatomic,strong) NSArray *rebate_code;

@end
