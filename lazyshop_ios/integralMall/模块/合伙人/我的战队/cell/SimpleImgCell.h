//
//  SimpleImgCell.h
//  integralMall
//
//  Created by liu on 2018/12/28.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "ImageLoadingUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleImgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

- (void)loadData:(PartnerMyPageFooterModel*)data withHasBtn:(BOOL)btnVisible;

@end

NS_ASSUME_NONNULL_END
