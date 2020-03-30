//
//  BargainListItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductRowBaseCellViewModel.h"

@class ProductRowBaseModel;

@interface BargainListItemCellViewModel : ProductRowBaseCellViewModel

@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy)NSString *activity_bargain_id;

- (instancetype)initWithProductRowBaseModel:(ProductRowBaseModel *)model;

@end
