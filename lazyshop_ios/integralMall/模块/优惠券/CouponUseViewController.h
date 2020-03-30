//
//  CouponUseViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class CouponUseViewModel;

typedef void (^CouponUseSuccessBlock)(RACTuple *tuple);

@interface CouponUseViewController : NavigationBarController

@property (nonatomic,strong)CouponUseViewModel *viewModel;

@property (nonatomic,copy) CouponUseSuccessBlock useSuccessBlock;

@end
