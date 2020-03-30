//
//  GoodsDetailCommentItemCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

#define CommentImageLeftGap 15.0f
#define CommentImageTopGap 10.0f
#define CommentImageItemGap 7.5f
#define CommentImageItemRowMaxCount 3
#define CommentImageItemWidth ((KScreenWidth-CommentImageItemGap*(CommentImageItemRowMaxCount-1)-CommentImageLeftGap*2)/CommentImageItemRowMaxCount)

@interface CommentRowItemCell : LYItemUIBaseCell

@end
