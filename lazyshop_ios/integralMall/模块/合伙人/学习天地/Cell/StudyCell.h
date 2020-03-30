//
//  StudyCell.h
//  integralMall
//
//  Created by liu on 2019/3/12.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Include.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgThumb;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;

- (void)loadData:(StudyModel*)model;

@end

NS_ASSUME_NONNULL_END
