//
//  GoodDetailPatternChooseHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailPramsDetailViewModel;

#define GoodDetailPatternChooseHeaderViewHeight 90.0f

@interface GoodDetailPatternChooseHeaderView : UIView

- (void)reloadDataWithViewModel:(GoodsDetailPramsDetailViewModel *)viewModel;

@end
