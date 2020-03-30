//
//  ConfirmDetailHeaderCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailHeaderCellViewModel.h"

#import "OrderDetailHeaderCell.h"

@implementation OrderDetailHeaderCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model

{
    self = [super init];
    if (self) {
        self.model = model;
        
        self.orderStatus = [model.order_status integerValue];
        self.UIClassName = NSStringFromClass([OrderDetailHeaderCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = KScreenWidth*138/750.;
        if (self.orderStatus == OrderStatus_ToPay ||
            self.orderStatus == OrderStatus_WaitStorePay) {
            // 支付剩余时间
            NSTimeInterval leftTime = [[CommUtls dencodeTime:model.pay_over_at] timeIntervalSinceNow];
            NSInteger days = leftTime/24/60/60;
            NSInteger hours = (leftTime-days)/60/60;
            if (leftTime>0) {
                self.timeTip = [NSString stringWithFormat:@"剩%02ld天%02ld小时取消",(long)days,(long)hours];
            }
        }
    }
    return self;
}

@end
