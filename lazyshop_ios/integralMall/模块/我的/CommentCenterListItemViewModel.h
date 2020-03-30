//
//  CommentCenterListItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCellViewModel.h"

@class CommentCenterModel;

@interface CommentCenterListItemViewModel : LYProductItemBaseCellViewModel

@property (nonatomic,assign) BOOL isComment;
@property (nonatomic,copy) NSString *order_detail_id;

- (instancetype)initWithModel:(CommentCenterModel *)model
                    isComment:(BOOL)isComment;

@end
