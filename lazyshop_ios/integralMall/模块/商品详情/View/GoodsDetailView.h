//
//  GoodsDetailView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailViewModel;

@interface GoodsDetailView : UIView

- (instancetype)initWithViewModel:(GoodsDetailViewModel *)viewModel;

- (void)reloadDataWithViewModel:(GoodsDetailViewModel *)viewModel;

- (void)changeViewAtIndex:(NSInteger)index;

@end
