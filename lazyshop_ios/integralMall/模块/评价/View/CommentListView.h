//
//  CommentListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class CommentListViewModel;

@interface CommentListView : AutoTableView

- (void)getData;

- (void)bindViewModel:(CommentListViewModel *)viewModel;

@end
