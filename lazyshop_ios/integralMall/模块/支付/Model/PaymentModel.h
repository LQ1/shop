//
//  PaymentModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface PaymentModel : BaseStringProModel

@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *pay_total_price;
@property (nonatomic,copy) NSString *pay_total_score;

@end
