//
//  BargainListItemCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BargainListItemCellViewModel.h"

#import "ProductRowBaseModel.h"

@implementation BargainListItemCellViewModel

- (instancetype)initWithProductRowBaseModel:(ProductRowBaseModel *)model
{
    self = [super init];
    if (self) {
        self.productID = model.goods_id;
        self.productName = model.title;
        self.productImageUrl = model.thumb;
        self.productPrice = model.price;
        self.slogan = model.slogan;
        self.goods_sku_id = model.goods_sku_id;
        self.activity_bargain_id = [model.activity_bargain_id lyStringValue];
    }
    return self;
}

@end
