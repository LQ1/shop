//
//  ComfirmDetailDescCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailDescCellViewModel.h"

#import "OrderDetailModel.h"

#import "OrderDetailDescCell.h"

@implementation OrderDetailDescCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model

{
    self = [super init];
    if (self) {
        if ([model.order_type integerValue]==OrderType_Score) {
            // 积分商品
            //  商品总价
            __block NSInteger goodsTotalScore = 0;
            [model.order_detail enumerateObjectsUsingBlock:^(OrderDetailGoodsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                goodsTotalScore+=[model.total_score integerValue];
            }];
            self.goodsTotalPrice = [NSString stringWithFormat:@"%ld积分",(long)goodsTotalScore];
            // 订单总价
            self.orderTotalPrice = self.goodsTotalPrice;
        }else{
            // 储值商品
            __block CGFloat goodsTotalPirce = 0.0f;
            [model.order_detail enumerateObjectsUsingBlock:^(OrderDetailGoodsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                goodsTotalPirce+=[model.total_price floatValue];
            }];
            //  商品总价
            self.goodsTotalPrice = [NSString stringWithFormat:@"¥ %.2f",goodsTotalPirce];
            //  订单总价
            self.orderTotalPrice = [NSString stringWithFormat:@"¥ %.2f",[self.postage floatValue]+goodsTotalPirce];
        }
        // 积分折扣
        self.integralDiscountPrice = [NSString stringWithFormat:@"-%d积分",(int)([model.subtract_price floatValue]*10)];
        
        // 运费
        self.postage = model.delivery_price;
        // 优惠金额
        self.subtract_price = model.subtract_price;
        
        self.UIClassName = NSStringFromClass([OrderDetailDescCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 120.;
    }
    return self;
}


@end
