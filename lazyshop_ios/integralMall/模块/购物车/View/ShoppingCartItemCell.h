//
//  ShoppingCartItemCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCell.h"

#import "LYQuantityAdderView.h"

typedef NS_ENUM(NSInteger,ShoppingCartItemCellClickType)
{
    ShoppingCartItemCellClickType_CheckBox = 0,
    ShoppingCartItemCellClickType_GoodsDetail
};

@interface ShoppingCartItemCell : LYProductItemBaseCell

@property (nonatomic,readonly) LYQuantityAdderView *adderView;

@end
