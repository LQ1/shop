//
//  GroupBuyListItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductRowBaseCellViewModel.h"

@class ProductRowBaseModel;

@interface GroupBuyListItemCellViewModel : ProductRowBaseCellViewModel

@property (nonatomic,copy) NSString *goods_sku_id;
@property (nonatomic,copy)NSString *activity_group_id;

- (instancetype)initWithProductRowBaseModel:(ProductRowBaseModel *)model;

@end
