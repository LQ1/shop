//
//  GoodDetailPatternChooseViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseViewController.h"

@class GoodsDetailPramsDetailViewModel;
@class GoodsDetailViewModel;

@interface GoodDetailPatternChooseViewController : BaseViewController

@property (nonatomic,strong)GoodsDetailPramsDetailViewModel *viewModel;
@property (nonatomic,strong)GoodsDetailViewModel *goodsDetailViewModel;

@end
