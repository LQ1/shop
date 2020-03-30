//
//  HomeSelectedCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeSelectedCellViewModel.h"

#import "HomeSelectedCell.h"
#import "HomeSelectedScrollItemModel.h"
#import "GoodsDetailViewModel.h"

@interface HomeSelectedCellViewModel ()

@property (nonatomic, strong) NSArray *recomItemModels;

@end

@implementation HomeSelectedCellViewModel

- (instancetype)initSelectedModels:(NSArray *)selecteds
                        recomModel:(HomeSelectedRecomModel *)model
{
    self = [super initWithItemModels:selecteds];
    if (self) {
        self.model = model;
        self.recomItemModels = [NSArray arrayWithArray:model.brand];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeSelectedCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeSelectedCell fetchCellHeight];
    }
    return self;
}

- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeSelectedScrollItemModel *model = [self.childViewModels objectAtIndex:indexPath.row];
    NSString *productID = [NSString stringWithFormat:@"%ld",(long)model.goods_id];
    GoodsDetailViewModel *vm = [[GoodsDetailViewModel alloc] initWithProductID:productID
                                                               goodsDetailType:GoodsDetailType_Normal
                                                             activity_flash_id:nil
                                                           activity_bargain_id:nil
                                                             activity_group_id:nil];
    return vm;
}

- (id)recommedModelAtIndex:(NSInteger)index
{
    if (self.recomItemModels.count>index) {
        return [self.recomItemModels objectAtIndex:index];
    }
    return nil;
}

@end
