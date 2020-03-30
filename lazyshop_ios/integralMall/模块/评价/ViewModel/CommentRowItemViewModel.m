//
//  GoodsDetailCommentItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentRowItemViewModel.h"

#import "CommentRowItemCell.h"

@implementation CommentRowItemViewModel

- (instancetype)initWithHeaderImgUrl:(NSString *)imgUrl
                            userName:(NSString *)userName
                       commentDetail:(NSString *)commentDetail
                    commentImageUrls:(NSArray *)commentImageUrls
                          created_at:(NSString *)created_at
{
    self = [super init];
    if (self) {
        self.headerImgUrl = imgUrl;
        self.userName = userName;
        self.commentDetail = commentDetail;
        self.created_at = created_at;
        if ([commentImageUrls isKindOfClass:[NSArray class]]) {
            self.commentImageUrls = commentImageUrls;
        }else if([commentImageUrls isKindOfClass:[NSString class]]){
            self.commentImageUrls = @[commentImageUrls];
        }
        self.UIClassName = NSStringFromClass([CommentRowItemCell class]);
        self.UIReuseID = self.UIClassName;
        
        NSInteger imagesRowCount =((self.commentImageUrls.count+CommentImageItemRowMaxCount-1)/CommentImageItemRowMaxCount);
        CGFloat imagesHeight = 10;
        if (imagesRowCount>0) {
            imagesHeight = CommentImageTopGap*2+(imagesRowCount-1)*CommentImageItemGap+imagesRowCount*CommentImageItemWidth;
        }
        self.UIHeight = 50+[CommUtls getContentSize:commentDetail
                                               font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                               size:CGSizeMake(KScreenWidth-15*2, CGFLOAT_MAX)].height+imagesHeight;
    }
    return self;
}

#pragma mark -images
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.commentImageUrls.count;
}

- (NSString *)imageUrlAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.commentImageUrls objectAtIndex:indexPath.row];
}

@end
