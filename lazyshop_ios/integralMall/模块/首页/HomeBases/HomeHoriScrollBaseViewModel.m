//
//  HomeHoriScrollBaseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeHoriScrollBaseViewModel.h"

@implementation HomeHoriScrollBaseViewModel

#pragma mark -初始化
- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    if (self = [super init]) {
        self.childViewModels = [NSArray arrayWithArray:itemModels];
    }
    return self;
}

#pragma mark -列表相关
- (NSInteger)itemCountAtSection:(NSInteger)section
{
    return self.childViewModels.count;
}

- (id)itemModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.childViewModels objectAtIndex:indexPath.row];
}

- (id)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
