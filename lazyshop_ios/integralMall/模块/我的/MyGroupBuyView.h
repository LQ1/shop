//
//  MyGroupBuyView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class MyGroupBuyViewModel;

@interface MyGroupBuyView : AutoTableView

- (void)reloadDataWithViewModel:(MyGroupBuyViewModel *)viewModel;

@end
