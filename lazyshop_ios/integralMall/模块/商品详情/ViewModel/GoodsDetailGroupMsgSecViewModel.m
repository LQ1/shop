//
//  GoodsDetailGroupMsgSecViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailGroupMsgSecViewModel.h"

#import "GoodsDetailGroupMsgViewModel.h"
#import "GoodsDetailGrayBarSectionView.h"

@implementation GoodsDetailGroupMsgSecViewModel

- (instancetype)initWithGroupMsgViewModel:(GoodsDetailGroupMsgViewModel *)groupMsgViewModel
{
    self = [super init];
    if (self) {
        self.childViewModels = @[groupMsgViewModel];
        self.UIClassName = NSStringFromClass([GoodsDetailGrayBarSectionView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = GoodsDetailGrayBarSectionViewHeight;
    }
    return self;
}


@end
