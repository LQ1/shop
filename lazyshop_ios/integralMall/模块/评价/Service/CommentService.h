//
//  CommentService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentService : NSObject

- (RACSignal *)getGoodsCommentWithGoods_id:(NSString *)goods_id;
- (RACSignal *)getOrderCommentWithOrder_detail_id:(NSString *)order_detail_id;

@end
