//
//  MakeMoneyBuyCell.h
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "ImageLoadingUtils.h"
#import "Utility.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeMoneyBuyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyText;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDT;

- (void)loadData:(MakeMoneyBuyInfoModel*)data;

@end

NS_ASSUME_NONNULL_END
