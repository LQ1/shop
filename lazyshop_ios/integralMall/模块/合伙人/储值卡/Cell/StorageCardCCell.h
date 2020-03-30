//
//  StorageCardCCell.h
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StorageCardCCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
- (void)loadData:(StorageCardModel*)data;

@end

NS_ASSUME_NONNULL_END
