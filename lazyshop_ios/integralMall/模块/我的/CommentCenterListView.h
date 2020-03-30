//
//  CommentCenterListView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class CommentCenterListViewModel;

@interface CommentCenterListView : AutoTableView

- (instancetype)initWithViewModel:(CommentCenterListViewModel *)viewModel;

@end
