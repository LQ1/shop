//
//  CouponCell.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Include.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponCell : UITableViewCell

- (void)loadData:(CouponListModel*)model;

@end

NS_ASSUME_NONNULL_END
