//
//  GoodsDetailHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailViewModel;

@interface GoodsDetailHeaderView : UIView

+ (CGFloat)fetchHeightWithViewModel:(GoodsDetailViewModel *)viewModel;

- (void)reloadDataWithViewModel:(GoodsDetailViewModel *)viewModel;

@end
