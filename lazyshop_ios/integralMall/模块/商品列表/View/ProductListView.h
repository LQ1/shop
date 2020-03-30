//
//  ProductListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductGridListView.h"
#import "ProductHoriListView.h"

@class ProductListViewModel;

@interface ProductListView : UIView

@property (nonatomic,readonly)ProductGridListView *gridListView;
@property (nonatomic,readonly)ProductHoriListView *horiListView;

- (instancetype)initWithViewModel:(ProductListViewModel *)viewModel;

- (void)setListHidden:(BOOL)hidden;

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel;

@end
