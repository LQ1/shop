//
//  HomeScoreCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeScoreCellViewModel.h"

#import "HomeScoreCell.h"
#import "ProductListViewModel.h"
#import "HomeScoreScrollItemModel.h"

@implementation HomeScoreCellViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels
                 scoreSingleImgUrl:(NSString *)scoreSingleImgUrl
{
    self = [super initWithItemModels:itemModels];
    if (self) {
        self.scoreSingleImgUrl = scoreSingleImgUrl;
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeScoreCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeScoreCell fetchCellHeight];
    }
    return self;
}

- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeScoreScrollItemModel *model = [self.childViewModels objectAtIndex:indexPath.row];
    ProductListViewModel *vm = [[ProductListViewModel alloc] initWithCartType:@"1"
                                                                 goods_cat_id:[model.cat_id lyStringValue]
                                                                  goods_title:nil];
    return vm;
}

@end
