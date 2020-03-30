//
//  ComfirmDetailTotalMoneyCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailTotalMoneyCellViewModel.h"

#import "OrderDetailModel.h"
#import "OrderDetailTotalMoneyCell.h"

@implementation OrderDetailTotalMoneyCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model
{
    self = [super init];
    if (self) {
        if ([model.order_type integerValue]==OrderType_Score) {
            self.payMoney = [NSString stringWithFormat:@"%@积分",model.pay_total_score];
        }else{
            self.payMoney = [NSString stringWithFormat:@"¥%@",model.pay_total_price];
        }
        self.UIClassName = NSStringFromClass([OrderDetailTotalMoneyCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 43;
    }
    return self;
}

@end
