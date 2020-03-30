//
//  IssueCommentViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DLBasePickerViewController.h"

typedef void (^issueCommentSuccess)(void);

@class IssueCommentViewModel;

@interface IssueCommentViewController : DLBasePickerViewController

@property (nonatomic,strong) IssueCommentViewModel *viewModel;

// 评价成功回调
@property (nonatomic,copy) dispatch_block_t commentSuccessBlock;

/**
 *  评价成功后刷新当前列表
 */
- (void)setDyAskBlock:(issueCommentSuccess)block;


@end
