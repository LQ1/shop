//
//  GoodsDetailPramsDetailViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class GoodDetailPatternDetailItemViewModel;

typedef NS_ENUM(NSInteger,GoodsPramsConfirmAction)
{
    GoodsPramsConfirmAction_None = 0,
    GoodsPramsConfirmAction_AddToCart,
    GoodsPramsConfirmAction_ImediatelyPay
};

@interface GoodsDetailPramsDetailViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy  )NSString *goods_sku_id;
@property (nonatomic,assign)BOOL useScanAttr;
@property (nonatomic,copy  )NSString *scanAttrValues;
@property (nonatomic,assign)NSInteger quantity;
@property (nonatomic,assign)BOOL confirmStyle;
@property (nonatomic,assign)GoodsPramsConfirmAction confirmAction;
@property (nonatomic,assign)BOOL isActivity;
@property (nonatomic,copy)NSString *activityAttrValues;

@property (nonatomic,strong)NSArray *selectAttrValueNames;

// 详情相关
@property (nonatomic,assign)NSInteger cartType;
@property (nonatomic,copy)NSString *productImgUrl;
@property (nonatomic,copy)NSString *productPrice;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *use_score;
@property (nonatomic,assign)NSInteger currentSkuStock;

/*
 *  获取展示标题
 */
- (NSString *)disPlayTitle;

// 详情相关
- (instancetype)initWithProductID:(NSString *)productID;

- (void)getData;

- (NSInteger)numberOfSections;
- (NSString *)sectionTitleAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (GoodDetailPatternDetailItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/*
 *  校验是否选择了全部商品属性
 */
- (BOOL)isAllAttrHasSelectedItem;
/*
 *  检验是否选择了sku
 */
- (BOOL)hasSelectedSku;

@end
