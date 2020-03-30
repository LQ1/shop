//
//  HomeSecKillItemCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeActivityImageWidth 100.0f
#define HomeActivityImageHeight 100.0f
#define HomeActivityBottomHeight 12.0f

#define HomeActivityCellWidth HomeActivityImageWidth
#define HomeActivityCellHeight (HomeActivityImageHeight+HomeActivityBottomHeight)

@class HomeActivityBaseModel;

@interface HomeActivityItemCell : UICollectionViewCell

- (void)reloadDataWithModel:(HomeActivityBaseModel *)itemModel;

@end
