//
//  CommentCenterClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentCenterClient : NSObject

/*
 *  评价列表
 */
- (RACSignal *)getCommentListWithIs_comment:(NSString *)is_comment
                                       page:(NSString *)page;

#pragma mark -添加评价
- (RACSignal *)addCommentWithOrder_detail_id:(NSString *)order_detail_id
                                     content:(NSString *)content
                                       image:(NSString *)image;

@end
