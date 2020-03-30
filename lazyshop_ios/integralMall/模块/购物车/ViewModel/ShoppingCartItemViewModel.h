//
//  ShoppingCartItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCellViewModel.h"

@interface ShoppingCartItemViewModel : LYProductItemBaseCellViewModel

@property (nonatomic,assign) NSInteger productQuantity;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString* goods_cart_id;

@property (nonatomic,assign) BOOL outStock;
@property (nonatomic,assign) BOOL underCart;


@property (nonatomic,assign) BOOL editting;
@property (nonatomic,assign) BOOL paySelected;
@property (nonatomic,assign) BOOL editSelected;

@end
