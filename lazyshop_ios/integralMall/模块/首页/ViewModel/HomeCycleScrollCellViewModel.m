//
//  HomeCycleScrollCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeCycleScrollCellViewModel.h"

#import "HomeCycleItemModel.h"
#import "HomeCycleScrollCell.h"

@interface HomeCycleScrollCellViewModel ()

@property (nonatomic,strong)NSArray *itemModels;

@end

@implementation HomeCycleScrollCellViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    self = [super init];
    if (self) {
        self.itemModels = [NSArray arrayWithArray:itemModels];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeCycleScrollCell class]);
        self.UIHeight = HomeViewHeaderHeight;
        self.UIReuseID = self.UIClassName;
    }
    return self;
}

- (NSString *)imgUrlAtIndex:(NSInteger)index
{
    HomeCycleItemModel *itemModel = [self.itemModels objectAtIndex:index];
    return itemModel.image;
}

- (NSInteger)linkTypeAtIndex:(NSInteger)index
{
    HomeCycleItemModel *itemModel = [self.itemModels objectAtIndex:index];
    return [itemModel.link_type integerValue];
}

- (NSString *)linkUrlAtIndex:(NSInteger)index
{
    HomeCycleItemModel *itemModel = [self.itemModels objectAtIndex:index];
    return itemModel.link.options.wz;
}

- (id)linkModelAtIndex:(NSInteger)index
{
    HomeCycleItemModel *itemModel = [self.itemModels objectAtIndex:index];
    return itemModel.link;
}

- (NSInteger)itemsCount
{
    return self.itemModels.count;
}


@end
