//
//  HomeRecommendCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeRecommendCellViewModel.h"

#import "HomeRecommendCell.h"
#import "HomeRecommendItemCell.h"

@implementation HomeRecommendCellViewModel

#pragma mark -init
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    self = [super init];
    if (self) {
        self.childViewModels = [NSArray arrayWithArray:itemModels];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeRecommendCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = HomeRecommendCellHeaderHeight + [HomeRecommendItemCell cellHeight]*self.childViewModels.count;
    }
    return self;
}


#pragma mark -table
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.childViewModels.count;
}

- (id)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.childViewModels objectAtIndex:indexPath.row];
}

@end
