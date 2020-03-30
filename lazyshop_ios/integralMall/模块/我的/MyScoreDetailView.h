//
//  MyScoreDetailView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class MyScoreViewModel;

@interface MyScoreDetailView : AutoTableView

- (instancetype)initWithViewModel:(MyScoreViewModel *)viewModel;

- (void)getDataMore:(BOOL)more;

@end
