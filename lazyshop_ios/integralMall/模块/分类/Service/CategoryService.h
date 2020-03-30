//
//  CategoryService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryService : NSObject

/**
 获取商品分类
 
 @param type 0储值商品 1积分商品
 @return <#return value description#>
 */
- (RACSignal *)getGoodsCategoryWithType:(NSInteger)type;

@end
