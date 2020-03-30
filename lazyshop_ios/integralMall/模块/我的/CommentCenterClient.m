//
//  CommentCenterClient.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterClient.h"

#define API_GET_COMMENT_LIST   @"http://"APP_DOMAIN@"/user/order/commentlist"
#define API_GET_COMMENT_ADD   @"http://"APP_DOMAIN@"/goods/comment/add"


@implementation CommentCenterClient

#pragma mark -评价列表
- (RACSignal *)getCommentListWithIs_comment:(NSString *)is_comment
                                       page:(NSString *)page
{
    is_comment = is_comment?:@"";
    
    NSDictionary *prams = @{
                            @"is_comment":is_comment,
                            @"token":SignInToken,
                            @"page":page
                            };
    
    return [LYHttpHelper GET:API_GET_COMMENT_LIST params:prams dealCode:YES];
}

#pragma mark -添加评价
- (RACSignal *)addCommentWithOrder_detail_id:(NSString *)order_detail_id
                                     content:(NSString *)content
                                       image:(NSString *)image
{
    order_detail_id = order_detail_id?:@"";
    content = content?:@"";
    image = image?:@"";

    NSDictionary *prams = @{
                            @"order_detail_id":order_detail_id,
                            @"token":SignInToken,
                            @"content":content,
                            @"image":image
                            };
    
    return [LYHttpHelper POST:API_GET_COMMENT_ADD params:prams dealCode:YES];
}

@end
