//
//  ProductListLayout.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListLayout.h"

#import "ProductlistItemMacro.h"

@implementation ProductListLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = ProductListItemItemGap;
        self.minimumLineSpacing = ProductListItemItemGap;
        self.itemSize = CGSizeMake(ProductListItemItemCellWidth, ProductListItemItemCellHeight);
        self.sectionInset = UIEdgeInsetsMake(ProductListItemItemCellSectionGap, 0, ProductListItemItemCellSectionGap, 0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end
