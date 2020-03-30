//
//  ProductListService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListService : NSObject

/*
 *  获取商品列表
 */
- (RACSignal *)getProductListWithPage:(NSInteger)page
                                 type:(NSInteger)type
                         goods_cat_id:(NSNumber *)goods_cat_id
                          goods_title:(NSString *)goods_title
                            min_score:(NSNumber *)min_score
                            max_score:(NSNumber *)max_score
                           sales_sort:(NSNumber *)sales_sort
                           score_sort:(NSNumber *)score_sort
                           price_sort:(NSNumber *)price_sort;

/*
 *  为你推荐
 */
- (RACSignal *)getRecommendProductListWithPage:(NSString *)page
                                          type:(NSString *)type;

@end
