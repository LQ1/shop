//
//  ProductSearchService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchService.h"

#import "ProductSearchHistoryModel.h"

@implementation ProductSearchService

#pragma mark -搜索记录
// 保存搜索记录
- (void)saveSearchKeywordToDatabase:(NSString *)keyword
{
    ProductSearchHistoryModel *historyModel = [ProductSearchHistoryModel new];
    historyModel.searchKeyword = keyword;
    
    ProductSearchHistoryModel *localModel = [ProductSearchHistoryModel searchWithWhere:@{@"searchKeyword":historyModel.searchKeyword}].linq_firstOrNil;
    if (localModel) {
        [localModel deleteToDB];
    }
    [historyModel saveToDB];
}
// 查询搜索记录
- (NSArray *)searchLocalSearchKeywords
{
    return [ProductSearchHistoryModel searchWithWhere:nil orderBy:@"_id desc" offset:0 count:0];
}
// 清空搜索记录
- (void)deleteAllSearchHistory
{
    [ProductSearchHistoryModel deleteWithWhere:nil];
}

@end
