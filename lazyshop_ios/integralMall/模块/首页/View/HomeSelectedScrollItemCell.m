//
//  HomeSelectedScrollItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeSelectedScrollItemCell.h"

#import "HomeSelectedScrollItemModel.h"

@implementation HomeSelectedScrollItemCell

- (void)reloadDataWithModel:(HomeSelectedScrollItemModel *)itemModel
{
    [self.imageView ly_showMinImg:itemModel.thumb];
}

@end
