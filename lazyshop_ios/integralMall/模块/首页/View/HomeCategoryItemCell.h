//
//  HomeCategoryItemCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCategoryItemModel;

@interface HomeCategoryItemCell : UICollectionViewCell

- (void)reloadDataWithModel:(HomeCategoryItemModel *)itemModel;

@end
