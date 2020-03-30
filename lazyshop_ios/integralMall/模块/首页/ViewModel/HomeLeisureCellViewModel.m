//
//  HomeLeisureCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeLeisureCellViewModel.h"

#import "HomeLeisureCell.h"

@implementation HomeLeisureCellViewModel

- (instancetype)initWithItemModels:(NSArray *)itemModels
{
    self = [super init];
    if (self) {
        self.childViewModels = [NSArray arrayWithArray:itemModels];
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeLeisureCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeLeisureCell cellHeight];
    }
    return self;
}

@end
