//
//  ProductListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger, ProductListViewModel_Signal_Type)
{
    ProductListViewModel_Signal_Type_TipLoading = 0,
    ProductListViewModel_Signal_Type_LoadingInView,
    ProductListViewModel_Signal_Type_GetDataSuccess,
    ProductListViewModel_Signal_Type_GetDataFail,
    ProductListViewModel_Signal_Type_GotoGoodsDetail,
    ProductListViewModel_Signal_Type_ShowSift
};

#define ProductListPageNumber 10

@interface ProductListViewModel : BaseViewModel

@property (nonatomic,readonly)ProductListViewModel_Signal_Type currentSignalType;

@property (nonatomic, readonly) BOOL isHoriListStyle;

@property (nonatomic,assign)NSInteger oldDataCount;

@property (nonatomic, readonly) NSInteger cartType;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, strong) NSNumber *goods_cat_id;
@property (nonatomic, strong) NSNumber *min_score;
@property (nonatomic, strong) NSNumber *max_score;

@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithCartType:(NSString *)cartType
                    goods_cat_id:(NSString *)goods_cat_id
                     goods_title:(NSString *)goods_title;

- (void)revalListStyle;
- (UIImage *)fetchRightNavImage;

- (void)getData;
- (void)getMoreData;

- (void)orderByDefault;
- (void)orderBySale;
- (void)orderByPrice:(BOOL)desc;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (id)cellVMForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)startToSift;

@end
