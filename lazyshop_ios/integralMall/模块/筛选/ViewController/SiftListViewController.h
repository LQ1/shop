//
//  SiftListViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseViewController.h"

@class SiftListViewModel;

typedef void (^siftCompleteBlock)(NSString *goods_cart_id,NSString *min_score,NSString *max_store);

@interface SiftListViewController : BaseViewController

@property (nonatomic,strong)SiftListViewModel *viewModel;

- (void)setSiftCompleteBlock:(siftCompleteBlock)block;

@end
