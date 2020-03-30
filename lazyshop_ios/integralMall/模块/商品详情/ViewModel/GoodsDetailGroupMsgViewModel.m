//
//  GoodsDetailGroupMsgViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailGroupMsgViewModel.h"

#import "GoodsDetailGroupMsgCell.h"

@implementation GoodsDetailGroupMsgViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.UIClassName = NSStringFromClass([GoodsDetailGroupMsgCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 40.0f;
    }
    return self;
}

@end
