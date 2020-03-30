//
//  ProductGridListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductListViewModel;

@interface ProductGridListView : UIView

@property (nonatomic,readonly)UICollectionView *mainCollectionView;

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel;

@end
