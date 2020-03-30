//
//  GoodDetailPatternChooseFooterView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailPramsDetailViewModel;
@class GoodsDetailViewModel;

#define GoodDetailPatternChooseFooterViewHeight 40.0f

@interface GoodDetailPatternChooseFooterView : UIView

- (instancetype)initWithGoodsDetailViewModel:(GoodsDetailViewModel *)viewModel;

- (void)reloadDataWithViewModel:(GoodsDetailPramsDetailViewModel *)viewModel;

@end
