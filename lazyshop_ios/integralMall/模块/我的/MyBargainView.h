//
//  MyBargainView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class MyBargainViewModel;

@interface MyBargainView : AutoTableView

- (void)reloadDataWithViewModel:(MyBargainViewModel *)viewModel;

@end
