//
//  HomeActivityBaseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeActivityBaseViewModel.h"

#import "HomeActivityBaseModel.h"
#import "GoodsDetailViewModel.h"

#import "HomeSecKillItemModel.h"
#import "HomeGroupByItemModel.h"
#import "HomeBargainItemModel.h"

@interface HomeActivityBaseViewModel()

@property (nonatomic,strong)NSArray *itemModels;

@end

@implementation HomeActivityBaseViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super init]) {
        self.itemModels = [NSArray arrayWithArray:itemModels];
    }
    return self;
}

#pragma mark -列表相关
- (NSInteger)itemCountAtSection:(NSInteger)section
{
    return self.itemModels.count;
}

- (HomeActivityBaseModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemModels objectAtIndex:indexPath.row];
}

- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeActivityBaseModel *itemModel = [self.itemModels objectAtIndex:indexPath.row];
    
    GoodsDetailType detailType;
    NSString *activity_flash_id = nil;
    NSString *activity_bargain_id = nil;
    NSString *activity_group_id = nil;
    if ([itemModel isKindOfClass:[HomeSecKillItemModel class]]) {
        // 秒杀
        HomeSecKillItemModel *secModel = (HomeSecKillItemModel *)itemModel;
        detailType = GoodsDetailType_SecKill;
        activity_flash_id = secModel.activity_flash_id;
    }else if ([itemModel isKindOfClass:[HomeBargainItemModel class]]){
        // 砍价
        HomeBargainItemModel *bargainModel = (HomeBargainItemModel *)itemModel;
        detailType = GoodsDetailType_Bargain;
        activity_bargain_id = bargainModel.activity_bargain_id;
    }else {
        // 拼团
        HomeGroupByItemModel *groupModel = (HomeGroupByItemModel *)itemModel;
        detailType = GoodsDetailType_GroupBy;
        activity_group_id = groupModel.activity_group_id;
    }
    // 跳转商品详情
    GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:itemModel.goods_id
                                                                     goodsDetailType:detailType
                                                                   activity_flash_id:activity_flash_id
                                                                 activity_bargain_id:activity_bargain_id
                                                                   activity_group_id:activity_group_id];
    return detailVM;
}

@end
