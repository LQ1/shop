//
//  CategoryThirdItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryThirdItemViewModel.h"

#import "CategoryModel.h"

@implementation CategoryThirdItemViewModel

- (instancetype)initWithCategoryModel:(CategoryModel *)model
{
    self = [super init];
    if (self) {
        self.thirdCategoryID = [NSString stringWithFormat:@"%ld",(long)model.goods_cat_id];
        self.thirdCategoryName = model.title;
        self.cat_type = model.cat_type;
        self.imgUrl = model.thumb;
    }
    return self;
}

@end
