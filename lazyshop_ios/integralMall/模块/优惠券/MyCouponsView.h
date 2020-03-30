//
//  MyCouponsView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class MyCouponsViewModel;

@interface MyCouponsView : AutoTableView

- (void)bindViewModel:(MyCouponsViewModel *)viewModel;

@end
