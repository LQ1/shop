//
//  OrderCommentDetailViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class CommentListViewModel;

@interface OrderCommentDetailViewController : NavigationBarController

@property (nonatomic,strong)CommentListViewModel *viewModel;

@end
