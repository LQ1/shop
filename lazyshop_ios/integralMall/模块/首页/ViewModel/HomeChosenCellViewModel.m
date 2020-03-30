//
//  HomeChosenCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeChosenCellViewModel.h"

#import "HomeChosenCell.h"
#import "HomeChosenMacro.h"
#import "ProductListItemViewModel.h"
#import "GoodsDetailViewModel.h"

@interface HomeChosenCellViewModel()

@end

@implementation HomeChosenCellViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super init]) {
        // 初始化数据源
        self.itemModels = [NSArray arrayWithArray:itemModels];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeChosenCell class]);
        self.UIReuseID = self.UIClassName;
        [self resetCellHeight];
    }
    return self;
}

#pragma mark -刷新高度
- (void)resetCellHeight
{
    NSInteger rowCount = (self.itemModels.count+1)/2;
    self.UIHeight = HomeChosenHeaderViewHeight +HomeChosenHeaderViewTopGap + ProductListItemItemCellHeight*rowCount + ProductListItemItemCellSectionGap*2 + ProductListItemItemGap*(rowCount - 1);
}

#pragma mark -列表相关
- (NSInteger)itemCountAtSection:(NSInteger)section
{
    return self.itemModels.count;
}

- (ProductListItemViewModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemModels objectAtIndex:indexPath.row];
}

- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListItemViewModel *itemModel = [self.itemModels objectAtIndex:indexPath.row];
    GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:itemModel.productID
                                                                     goodsDetailType:GoodsDetailType_Normal
                                                                   activity_flash_id:nil
                                                                 activity_bargain_id:nil
                                                                   activity_group_id:nil];
    return detailVM;
}

@end
