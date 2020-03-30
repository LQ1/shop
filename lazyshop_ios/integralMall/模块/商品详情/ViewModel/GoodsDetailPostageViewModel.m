//
//  GoodsDetailPostageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPostageViewModel.h"

#import "GoodsTagModel.h"
#import "GoodsDetailPostageCell.h"

@interface GoodsDetailPostageViewModel()

@property (nonatomic,strong)NSArray *goodsTagModels;

@end

@implementation GoodsDetailPostageViewModel

- (instancetype)initWithPostage:(NSString *)postage
                 goodsTagModels:(NSArray *)goodsTagModels
{
    self = [super init];
    if (self) {
        self.postage = postage;
        self.goodsTagModels = goodsTagModels;
        self.UIClassName = NSStringFromClass([GoodsDetailPostageCell class]);
        self.UIReuseID = self.UIClassName;
        NSInteger rowCount = (goodsTagModels.count+(GoodsDetailPostageCellRowMax-1))/GoodsDetailPostageCellRowMax;
        self.UIHeight = GoodsDetailPostageCellBaseHeight*(rowCount+1);
    }
    return self;
}

#pragma mark -list
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.goodsTagModels.count;
}

- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTagModel *model = [self.goodsTagModels objectAtIndex:indexPath.row];
    return model.goods_tag_title;
}

@end
