//
//  CategoryRightItemCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryThirdItemViewModel;

@interface CategoryRightItemCell : UICollectionViewCell

- (void)reloadDataWithViewModel:(CategoryThirdItemViewModel *)viewModel;

@end
