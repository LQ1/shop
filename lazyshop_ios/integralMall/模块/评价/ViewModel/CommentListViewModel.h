//
//  CommentListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CommentRowItemViewModel;

typedef NS_ENUM(NSInteger,CommentType) {
    CommentType_GoodsDetail = 0,
    CommentType_OrderDetail
};

@interface CommentListViewModel : BaseViewModel

- (instancetype)initWithCommentType:(CommentType)commentType
                           goods_id:(NSString *)goods_id
                    order_detail_id:(NSString *)order_detail_id;

- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CommentRowItemViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
