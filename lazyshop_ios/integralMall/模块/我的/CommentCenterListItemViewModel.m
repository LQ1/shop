//
//  CommentCenterListItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterListItemViewModel.h"

#import "CommentCenterModel.h"
#import "CommentCenterListItemCell.h"

@implementation CommentCenterListItemViewModel

- (instancetype)initWithModel:(CommentCenterModel *)model
                    isComment:(BOOL)isComment
{
    self = [super init];
    if (self) {
        self.isComment = isComment;
        self.order_detail_id = model.order_detail_id;
        self.productName = model.goods_title;
        self.productImgUrl = model.goods_thumb;
        self.productPrice = model.price;
        self.productSkuString = model.attr_values;
        self.UIClassName = NSStringFromClass([CommentCenterListItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 110.f;
    }
    return self;
}

@end
