//
//  ProductSearchService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSearchService : NSObject

- (void)saveSearchKeywordToDatabase:(NSString *)keyword;
- (NSArray *)searchLocalSearchKeywords;
- (void)deleteAllSearchHistory;

@end
