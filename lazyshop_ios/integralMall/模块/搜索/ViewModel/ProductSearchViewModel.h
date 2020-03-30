//
//  ProductSearchViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

#import "ProductSearchMacro.h"

typedef NS_ENUM(NSInteger, ProductSearchViewModel_Signal_Type)
{
    ProductSearchViewModel_Signal_Type_ExsitsHistory = 0,
    ProductSearchViewModel_Signal_Type_NoHistory,
    ProductSearchViewModel_Signal_Type_GotoProductList,
    ProductSearchViewModel_Signal_Type_BackSearchTitle
};

@interface ProductSearchViewModel : BaseViewModel


@property (nonatomic,readonly)ProductSearchViewModel_Signal_Type currentSignalType;

- (instancetype)initWithProductSearchFrom:(ProductSearchFrom)from;

/*
 *  获取搜索历史
 */
- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 *  开始搜索
 */
- (void)startToSearchKeyword:(NSString *)keyword;

/*
 *  清空搜索
 */
- (void)clearSearchHistory;

@end
