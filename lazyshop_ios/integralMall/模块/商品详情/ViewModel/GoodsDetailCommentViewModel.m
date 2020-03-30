//
//  GoodsDetailCommentViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCommentViewModel.h"

#import "GoodsDetailCommentSectionView.h"

@implementation GoodsDetailCommentViewModel

- (instancetype)initWithCommentCount:(NSInteger)count
                      commentDetails:(NSArray *)commentDetails
{
    self = [super init];
    if (self) {
        self.commentCount = count;
        self.childViewModels = commentDetails;
        self.UIClassName = NSStringFromClass([GoodsDetailCommentSectionView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = GoodsDetailCommentSectionViewHeight;
    }
    return self;
}

@end
