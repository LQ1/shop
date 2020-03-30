//
//  ProductListItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class ProductListItemModel;

@interface ProductListItemViewModel : LYItemUIBaseViewModel

/*
 *  商品ID
 */
@property (nonatomic,copy)NSString *productID;
/*
 *  商品图片
 */
@property (nonatomic,copy)NSString *imgUrl;
/*
 *  商品名称
 */
@property (nonatomic,copy)NSString *productName;
/*
 *  商品类型
 */
@property (nonatomic,assign)NSInteger cartType;
/*
 *  商品价格
 */
@property (nonatomic,copy)NSString *price;
/*
 *  商品积分
 */
@property (nonatomic,copy)NSString *score;
/*
 *  配置文案
 */
@property (nonatomic,copy)NSString *slogan;
/*
 *  券
 */
@property (nonatomic,assign)BOOL is_coupon;

- (instancetype)initWithModel:(ProductListItemModel *)itemModel;

@end
