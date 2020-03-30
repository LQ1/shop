//
//  ConrimDetailGoodsItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailGoodsItemViewModel.h"

#import "OrderDetailGoodsItemCell.h"
#import "OrderDetailGoodsModel.h"

@implementation OrderDetailGoodsItemViewModel

- (instancetype)initWithModel:(OrderDetailGoodsModel *)model
{
    self = [super init];
    if (self) {
        self.productID = model.goods_id;
        self.productName = model.goods_title;
        if ([model.order_type integerValue]==OrderType_Score) {
            self.productPrice = [NSString stringWithFormat:@"%@积分",model.score];
        }else{
            self.productPrice = [NSString stringWithFormat:@"¥ %@",model.price];
        }
        self.productImgUrl = model.goods_thumb;
        self.productSkuString = model.attr_values;
        self.quantity = model.quantity;
        self.UIClassName = NSStringFromClass([OrderDetailGoodsItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 110.f;
    }
    return self;
}

@end
