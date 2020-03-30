//
//  GoodsDetailPramsViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPramsViewModel.h"

#import "GoodsDetailPramsDetailViewModel.h"
#import "GoodsDetailGrayBarSectionView.h"

@implementation GoodsDetailPramsViewModel

- (instancetype)initWithProductID:(NSString *)productID
{
    self = [super init];
    if (self) {
        GoodsDetailPramsDetailViewModel *detailVM = [[GoodsDetailPramsDetailViewModel alloc] initWithProductID:productID];
        self.childViewModels = @[detailVM];
        
        self.UIClassName = NSStringFromClass([GoodsDetailGrayBarSectionView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = GoodsDetailGrayBarSectionViewHeight;
    }
    return self;
}

@end
