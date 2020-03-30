//
//  StorageBuyViewController.h
//  integralMall
//
//  Created by liu on 2018/12/29.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "include.h"
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StorageBuyViewController : BasePartnerViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

@property (assign, nonatomic) int store_card_id;

@end

NS_ASSUME_NONNULL_END
