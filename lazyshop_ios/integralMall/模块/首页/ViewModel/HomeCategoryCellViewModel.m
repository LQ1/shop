//
//  HomeCategoryCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeCategoryCellViewModel.h"

#import "HomeCategoryItemModel.h"
#import "HomeCategoryCell.h"
#import "HomeCategoryMacro.h"

// 商品列表
#import "ProductListViewController.h"
#import "ProductListViewModel.h"

@interface HomeCategoryCellViewModel()

@property (nonatomic,strong)NSArray *itemModels;

@end

@implementation HomeCategoryCellViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super init]) {
        // 初始化数据源
        self.itemModels = [itemModels linq_take:HomeCategoryCellMaxTotalItemCount];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeCategoryCell class]);
        self.UIReuseID = self.UIClassName;
        if (self.itemModels.count>HomeCategoryCellMaxRowItemCount) {
            self.UIHeight = HomeCategoryItemCellHeight*2+HomeCategoryLayoutTopGap+HomeCategoryLayoutBottomGap+HomeCategoryLayoutLineGap;
        }else{
            self.UIHeight = HomeCategoryItemCellHeight+HomeCategoryLayoutTopGap+HomeCategoryLayoutBottomGap;
        }
    }
    return self;
}

#pragma mark -列表相关
- (NSInteger)itemCountAtSection:(NSInteger)section
{
    return self.itemModels.count;
}

- (HomeCategoryItemModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemModels objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCategoryItemModel *itemModel = [self itemModelAtIndexPath:indexPath];
    ProductListViewModel *vm = [[ProductListViewModel alloc] initWithCartType:[itemModel.goods_cat_type lyStringValue]
                                                                 goods_cat_id:[itemModel.goods_cat_id lyStringValue]
                                                                  goods_title:nil];
    ProductListViewController *vc = [ProductListViewController new];
    vc.viewModel = vm;
    vc.hidesBottomBarWhenPushed = YES;
    [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc
                                                                      animated:YES];
}

@end
