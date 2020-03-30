//
//  ProductListHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProductListHeaderViewHeight 40.0f

@class ProductListViewModel;

typedef NS_ENUM(NSInteger,ProductListHeaderViewClickType)
{
    ProductListHeaderViewClickType_OrderByDefault,
    ProductListHeaderViewClickType_OrderBySales,
    ProductListHeaderViewClickType_OrderByPrice,
    ProductListHeaderViewClickType_OrderByPriceDesc,
    ProductListHeaderViewClickType_Sift
};

@interface ProductListHeaderView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel;

@end
