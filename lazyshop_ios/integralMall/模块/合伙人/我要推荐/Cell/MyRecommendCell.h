//
//  MyRecommendCell.h
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;

- (void)loadData:(RecommendInfoModel*)data;

@end

NS_ASSUME_NONNULL_END
