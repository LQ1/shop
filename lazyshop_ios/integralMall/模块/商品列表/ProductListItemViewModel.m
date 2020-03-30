//
//  ProductListItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListItemViewModel.h"

#import "ProductListItemModel.h"

@implementation ProductListItemViewModel

- (instancetype)initWithModel:(ProductListItemModel *)itemModel
{
    if (self = [super init]) {
        self.productID = itemModel.goods_id;
        self.imgUrl = itemModel.thumb;
        self.productName = itemModel.goods_title;
        self.price = itemModel.price;
        self.slogan = itemModel.slogan;
        self.is_coupon = itemModel.is_coupon==1?YES:NO;
    }
    return self;
}

@end
