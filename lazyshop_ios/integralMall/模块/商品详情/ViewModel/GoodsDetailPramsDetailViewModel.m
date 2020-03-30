//
//  GoodsDetailPramsDetailViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPramsDetailViewModel.h"

#import "GoodsDetailPramsChooseCell.h"
// 详情相关
#import "GoodDetailPatternCategoryViewModel.h"
#import "GoodDetailPatternDetailItemViewModel.h"

#import "GoodsDetailService.h"
#import "GoodsAttrModel.h"
#import "GoodsAttrValueModel.h"
#import "GoodsSkuModel.h"

#define CombineGapString @","

@interface GoodsDetailPramsDetailViewModel()

@property (nonatomic,copy)NSString *productID;

@property (nonatomic,strong)NSArray *GoodsAttrModels;
@property (nonatomic,strong)NSArray *GoodsSkuModels;
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)NSMutableArray *allAttrValueCombines;

@property (nonatomic,assign)BOOL hasFetchedData;

@property (nonatomic,strong)GoodsDetailService *service;

@end

@implementation GoodsDetailPramsDetailViewModel

- (instancetype)initWithProductID:(NSString *)productID
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([GoodsDetailPramsChooseCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 40.0f;
        // 详情相关
        self.productID = productID;
        self.service = [GoodsDetailService new];
    }
    return self;
}

- (NSString *)disPlayTitle
{
    if (self.goods_sku_id.length<=0) {
        return @"未填写";
    }else{
        if (self.isActivity) {
            // 活动商品 接口返回sku
            return [self.activityAttrValues stringByAppendingString:@",1件"];
        }else{
            if (self.useScanAttr) {
                return [self.scanAttrValues stringByAppendingString:@",1件"];
            }else{
                // 其他商品是用户选择的sku
                return [[self.selectAttrValueNames componentsJoinedByString:CombineGapString] stringByAppendingString:[NSString stringWithFormat:@",%ld件",(long)self.quantity]];
            }
        }
    }
}

// ---详情相关

#pragma mark -获取数据
- (void)getData
{
    if (self.hasFetchedData) {
        [self.updatedContentSignal sendNext:nil];
        return;
    }
    
    @weakify(self);
    RACDisposable *disPos = [[[self.service fetchGoodsAttrWithGoodID:self.productID] flattenMap:^RACStream *(id attrs) {
        @strongify(self);
        self.GoodsAttrModels = attrs;
        return [self.service fetchGoodsSkuWithGoodsID:self.productID];
    }] subscribeNext:^(id skus) {
        @strongify(self);
        self.GoodsSkuModels = skus;
        [self dealDataWithGoodsAttrModels:self.GoodsAttrModels];
        self.hasFetchedData = YES;
        // 开始处理数据
        [self reloadItemsValidStateAtIndexPath:nil];
        // 数据刷新信号
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithGoodsAttrModels:(NSArray *)goodsAttrModels
{
    self.quantity = 1;
    NSMutableArray *resultArray = [NSMutableArray array];
    [goodsAttrModels enumerateObjectsUsingBlock:^(GoodsAttrModel *attrModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *attrValues = [NSMutableArray array];
        [attrModel.values enumerateObjectsUsingBlock:^(GoodsAttrValueModel *attrValueModel, NSUInteger idx, BOOL * _Nonnull stop) {
            GoodDetailPatternDetailItemViewModel *attrValueVM = [[GoodDetailPatternDetailItemViewModel alloc] initWithPatternDetailName:attrValueModel.goods_attr_value patternDetailID:[attrValueModel.goods_attr_value_id lyStringValue]];
            [attrValues addObject:attrValueVM];
        }];
        GoodDetailPatternCategoryViewModel *attrVM = [[GoodDetailPatternCategoryViewModel alloc] initWithCategoryName:attrModel.goods_attr_name categoryID:[attrModel.goods_attr_id lyStringValue] patternDetails:attrValues];
        [resultArray addObject:attrVM];
    }];
    self.dataArray = [NSArray arrayWithArray:resultArray];
    // 如果有sku_id就要根据sku_id选中相应项目
    if (self.scanAttrValues.length) {
        [self initSelectedMsg];
    }
}
// 初始化选中信息
- (void)initSelectedMsg
{
    NSArray *attrValuesArray = [self.scanAttrValues componentsSeparatedByString:CombineGapString];
    [self.dataArray enumerateObjectsUsingBlock:^(GoodDetailPatternCategoryViewModel *attrVM, NSUInteger idx1, BOOL * _Nonnull stop) {
        [attrVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *attrValueVM, NSUInteger idx2, BOOL * _Nonnull stop) {
            if (attrValuesArray.count>idx1) {
                if ([attrValueVM.patternDetailName isEqualToString:[attrValuesArray objectAtIndex:idx1]]) {
                    attrValueVM.selected = YES;
                }
            }
        }];
    }];
    // 设置选中attrValues
    [self resetSelectedAttrValues];
    // 标记值
    self.useScanAttr = NO;
    // 数据刷新信号
    [self.updatedContentSignal sendNext:nil];
}

#pragma mark -列表相关
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (NSString *)sectionTitleAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailPatternCategoryViewModel *categoryVM = [self.dataArray objectAtIndex:indexPath.section];
    return categoryVM.patternCategoryName;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    GoodDetailPatternCategoryViewModel *categoryVM = [self.dataArray objectAtIndex:section];
    return categoryVM.childViewModels.count;
}

- (GoodDetailPatternDetailItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailPatternCategoryViewModel *categoryVM = [self.dataArray objectAtIndex:indexPath.section];
    return [categoryVM.childViewModels objectAtIndex:indexPath.row];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailPatternCategoryViewModel *toBeSelectedCategoryVM = [self.dataArray objectAtIndex:indexPath.section];
    GoodDetailPatternDetailItemViewModel *toBeSelectedItemVM = [toBeSelectedCategoryVM.childViewModels objectAtIndex:indexPath.row];
    
    if (toBeSelectedItemVM.selected) {
        // 选中已选中 返回
        return;
    }else{
        if (toBeSelectedItemVM.invalid) {
            // 选中不可用
            //  其他全部未选中
            [self.dataArray enumerateObjectsUsingBlock:^(GoodDetailPatternCategoryViewModel *categoryVM, NSUInteger idx, BOOL * _Nonnull stop) {
                [categoryVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
                    itemVM.selected = NO;
                }];
            }];
            //  此项选中
            toBeSelectedItemVM.selected = YES;
            //  重新计算各项状态 同时会校验是否匹配sku
            [self reloadItemsValidStateAtIndexPath:indexPath];
        }else{
            // 选中可用
            //  同组其他未选中
            [toBeSelectedCategoryVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
                itemVM.selected = NO;
            }];
            //  此项选中
            toBeSelectedItemVM.selected = YES;
            //  联合其他组选中状态重新计算各项状态 同时会校验是否匹配sku
            [self reloadItemsValidStateAtIndexPath:indexPath];
        }
    }
    [self resetSelectedAttrValues];
}

#pragma mark -attrValue状态重置
// 根据选中信息计算所有项目的可用状态
- (void)reloadItemsValidStateAtIndexPath:(NSIndexPath *)indexPath
{
    // 先让所有未选中的不可用
    [self.dataArray enumerateObjectsUsingBlock:^(GoodDetailPatternCategoryViewModel *categoryVM, NSUInteger idx, BOOL * _Nonnull stop) {
        [categoryVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
            itemVM.invalid = !itemVM.selected;
        }];
    }];
    // 获取所有可校验的数据组合
    self.allAttrValueCombines = [NSMutableArray array];
    NSMutableArray *allAttrValues = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(GoodDetailPatternCategoryViewModel *categoryVM, NSUInteger idx1, BOOL * _Nonnull stop) {
        NSMutableArray *secAttrValues = [NSMutableArray array];
        
        GoodDetailPatternDetailItemViewModel *selectedItemVM = [categoryVM.childViewModels linq_where:^BOOL(GoodDetailPatternDetailItemViewModel *itemVM) {
            return itemVM.selected == YES;
        }].linq_firstOrNil;
        if (selectedItemVM) {
            // 如果有选中的 使用选中的校验
            [secAttrValues addObject:[NSString stringWithFormat:@"%@%@%@",selectedItemVM.patternDetailName,CombineGapString,selectedItemVM.patternDetailID]];
        }else{
            // 使用全部进行校验
            [categoryVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *itemVM, NSUInteger idx2, BOOL * _Nonnull stop) {
                [secAttrValues addObject:[NSString stringWithFormat:@"%@%@%@",itemVM.patternDetailName,CombineGapString,itemVM.patternDetailID]];
            }];
        }
        [allAttrValues addObject:secAttrValues];
    }];
    NSMutableArray* result = [NSMutableArray array];
    [self combine:result data:allAttrValues curr:0 count:(int)allAttrValues.count];
    // 校验组合是否是可用的sku
    [self checkAllCombinesIsValidSku];
}
// 校验各组合是否可用的sku
- (void)checkAllCombinesIsValidSku
{
    @weakify(self);
    [self.allAttrValueCombines enumerateObjectsUsingBlock:^(NSArray *combine, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *attrValuesString = [[combine linq_select:^id(NSString *attrValue) {
            return [attrValue componentsSeparatedByString:CombineGapString].linq_firstOrNil;
        }] componentsJoinedByString:CombineGapString];
        // 校验attrvalues是否可用
        BOOL isValidSku = [self.GoodsSkuModels linq_any:^BOOL(GoodsSkuModel *skuModel) {
            //[skuModel.stock integerValue]>0 &&
            return [skuModel.attr_values_md5 isEqualToString:[attrValuesString MD5Digest]];
        }];
        if (isValidSku) {
            // 置为可用
            NSArray *attrValueIDs = [combine linq_select:^id(NSString *attrValue) {
                return [attrValue componentsSeparatedByString:CombineGapString].linq_lastOrNil;
            }];
            [attrValueIDs enumerateObjectsUsingBlock:^(NSString *attrValueID, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                [self.dataArray enumerateObjectsUsingBlock:^(GoodDetailPatternCategoryViewModel *categoryVM, NSUInteger idx, BOOL * _Nonnull stop) {
                    [categoryVM.childViewModels enumerateObjectsUsingBlock:^(GoodDetailPatternDetailItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([itemVM.patternDetailID isEqualToString:attrValueID]) {
                            itemVM.invalid = NO;
                        }
                    }];
                }];
            }];
        }
    }];
    // 如果全部都选中了 设置商品sku
    [self checkToSetSku];
}
// 校验是否可以设置sku
- (void)checkToSetSku
{
    NSMutableArray *selectedAttrValues = [NSMutableArray array];
    BOOL selectedAll = [self.dataArray linq_all:^BOOL(GoodDetailPatternCategoryViewModel *categoryVM) {
        return [categoryVM.childViewModels linq_any:^BOOL(GoodDetailPatternDetailItemViewModel *itemVM) {
            if (itemVM.selected == YES) {
                [selectedAttrValues addObject:itemVM.patternDetailName];
                return YES;
            }
            return NO;
        }];
    }];
    if (selectedAll) {
        NSString *selectAttrsMd5 = [[selectedAttrValues componentsJoinedByString:CombineGapString] MD5Digest];
        GoodsSkuModel *currentSkuModel = [self.GoodsSkuModels linq_where:^BOOL(GoodsSkuModel *skuModel) {
            return [skuModel.attr_values_md5 isEqualToString:selectAttrsMd5];
        }].linq_firstOrNil;
        [self setSkuWithModel:currentSkuModel];
    }else{
        [self setSkuWithModel:nil];
    }
}
// 设置sku
- (void)setSkuWithModel:(GoodsSkuModel *)skuModel
{
    // &&[skuModel.stock integerValue]>0
    if (skuModel) {
        self.productImgUrl = skuModel.thumb;
        self.productPrice = skuModel.price;
        self.score = skuModel.score;
        self.use_score = skuModel.use_score;
        self.goods_sku_id = [skuModel.goods_sku_id lyStringValue];
        self.currentSkuStock = [skuModel.stock integerValue];
    }else{
        self.productImgUrl = nil;
        self.productPrice = nil;
        self.score = nil;
        self.use_score = nil;
        self.goods_sku_id = nil;
        self.currentSkuStock = 0;
    }
}
// 组合数据
- (void)combine:(NSMutableArray *)result
           data:(NSArray *)data
           curr:(int)currIndex
          count:(int)count
{
    if (currIndex == count) {
        [self.allAttrValueCombines addObject:[result mutableCopy]];
        [result removeLastObject];
        
    }else {
        
        NSArray* array = [data objectAtIndex:currIndex];
        
        for (int i = 0; i < array.count; ++i)
        {
            [result addObject:[array objectAtIndex:i]];
            //进入递归循环
            [self combine:result data:data curr:currIndex+1 count:count];
            
            if ((i+1 == array.count) && (currIndex-1>=0)) {
                [result removeObjectAtIndex:currIndex-1];
            }
        }
    }
}
// 赋值当前选中的attrValues
- (void)resetSelectedAttrValues
{
    self.selectAttrValueNames = [self.dataArray linq_select:^id(GoodDetailPatternCategoryViewModel *categoryVM) {
        GoodDetailPatternDetailItemViewModel *selectedItemVM = [categoryVM.childViewModels linq_where:^BOOL(GoodDetailPatternDetailItemViewModel *itemVM) {
            return itemVM.selected == YES;
        }].linq_firstOrNil;
        return selectedItemVM.patternDetailName;
    }];
}

#pragma mark -布局相关
-(CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailPatternDetailItemViewModel *itemVM = [self itemViewModelAtIndexPath:indexPath];
    return CGSizeMake(itemVM.UIWidth, itemVM.UIHeight);
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 9.0;
}

#pragma mark -校验是否选全商品参数
- (BOOL)isAllAttrHasSelectedItem
{
    // 如果每行均选中但是无sku 提示暂无此商品样式
    BOOL allRowHasAnySelected = [self.dataArray linq_all:^BOOL(GoodDetailPatternCategoryViewModel *cateVM) {
        return [cateVM.childViewModels linq_any:^BOOL(GoodDetailPatternDetailItemViewModel *itemVM) {
            return itemVM.selected == YES;
        }];
    }];
    return allRowHasAnySelected;
}

- (BOOL)hasSelectedSku
{
    if (self.goods_sku_id.length>0) {
        return YES;
    }
    return NO;
}

@end
