//
//  ProductSearchViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchViewModel.h"

#import "ProductSearchService.h"
#import "ProductSearchHistoryModel.h"
#import "ProductListViewModel.h"

@interface ProductSearchViewModel()

@property (nonatomic,strong) ProductSearchService *service;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign)ProductSearchViewModel_Signal_Type currentSignalType;
@property (nonatomic,assign)ProductSearchFrom searchFrom;

@end

@implementation ProductSearchViewModel

- (instancetype)initWithProductSearchFrom:(ProductSearchFrom)from
{
    self = [super init];
    if (self) {
        self.searchFrom = from;
        self.service = [ProductSearchService new];
    }
    return self;
}

#pragma mark -获取搜索历史
- (void)getData
{
    self.dataArray = [self searchLocalSearchKeywords];
    if (self.dataArray.count) {
        self.currentSignalType = ProductSearchViewModel_Signal_Type_ExsitsHistory;
        [self.updatedContentSignal sendNext:nil];
    }else{
        self.currentSignalType = ProductSearchViewModel_Signal_Type_NoHistory;
        [self.updatedContentSignal sendNext:nil];
    }
}

#pragma mark -列表相关
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductSearchHistoryModel *model = [self cellModelForRowAtIndexPath:indexPath];
    [self startToSearchKeyword:model.searchKeyword];
}

#pragma mark -开始搜索
- (void)startToSearchKeyword:(NSString *)keyword
{
    [self saveSearchKeywordToDatabase:keyword];
    [self getData];
    
    switch (self.searchFrom) {
        case ProductSearchFrom_HomePage:
        {
            // 跳转商品列表
            self.currentSignalType = ProductSearchViewModel_Signal_Type_GotoProductList;
            ProductListViewModel *vm = [[ProductListViewModel alloc] initWithCartType:@"0" goods_cat_id:nil goods_title:keyword];
            [self.updatedContentSignal sendNext:vm];
        }
            break;
        case ProductSearchFrom_ProductList:
        {
            // 回传搜索字段
            self.currentSignalType = ProductSearchViewModel_Signal_Type_BackSearchTitle;
            [self.updatedContentSignal sendNext:keyword];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -清空搜索
- (void)clearSearchHistory
{
    [self.service deleteAllSearchHistory];
    [self getData];
}

#pragma mark -搜索历史
// 保存搜索记录
- (void)saveSearchKeywordToDatabase:(NSString *)keyword
{
    [self.service saveSearchKeywordToDatabase:keyword];
}
// 查询搜索记录
- (NSArray *)searchLocalSearchKeywords
{
    return [self.service searchLocalSearchKeywords];
}

@end
