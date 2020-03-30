//
//  ProductListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListViewModel.h"

#import "ProductListItemViewModel.h"
#import "ProductListItemModel.h"

#import "GoodsDetailViewModel.h"
#import "SiftListViewModel.h"

#import "ProductListService.h"

@interface ProductListViewModel()

@property (nonatomic,assign)ProductListViewModel_Signal_Type currentSignalType;

// 列表UI风格
@property (nonatomic,assign) BOOL isHoriListStyle;
// 列表类型
@property (nonatomic,assign)NSInteger cartType;
// 两者共有
@property (nonatomic,strong)NSNumber *sales_sort;
// 储值特有
@property (nonatomic,strong)NSNumber *price_sort;
// 积分特有
@property (nonatomic,strong)NSNumber *score_sort;

@property (nonatomic,strong)ProductListService *service;

@end

@implementation ProductListViewModel

#pragma mark -初始化
- (instancetype)initWithCartType:(NSString *)cartType
                    goods_cat_id:(NSString *)goods_cat_id
                     goods_title:(NSString *)goods_title
{
    self = [super init];
    if (self) {
        self.service = [ProductListService new];
        self.cartType = [cartType integerValue];
        self.goods_cat_id = [NSNumber numberWithInteger:[goods_cat_id integerValue]];
        self.goods_title = goods_title;
    }
    return self;
}

#pragma mark -列表UI风格
- (void)revalListStyle
{
    self.isHoriListStyle = !self.isHoriListStyle;
}
- (UIImage *)fetchRightNavImage
{
    if (self.isHoriListStyle) {
        return [UIImage imageNamed:@"列表切换1"];
    }else{
        return [UIImage imageNamed:@"列表切换2"];
    }
}

#pragma mark -获取数据
// 获取最新数据
- (void)getData
{
    self.oldDataCount = 0;
    [self getDataWithPage:1];
}
// 获取下拉加载数据
- (void)getMoreData
{
    [self getDataWithPage:[[PublicEventManager getPageNumberWithCount:self.dataArray.count] integerValue]];
}
// 获取page后10条数据
- (void)getDataWithPage:(NSInteger)page
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getProductListWithPage:page
                                                             type:self.cartType
                                                     goods_cat_id:self.goods_cat_id
                                                      goods_title:self.goods_title
                                                        min_score:self.min_score
                                                        max_score:self.max_score
                                                       sales_sort:self.sales_sort
                                                       score_sort:self.score_sort
                                                       price_sort:self.price_sort] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithProductModels:x appending:page>1?YES:NO];
        self.currentSignalType = ProductListViewModel_Signal_Type_GetDataSuccess;
        [self.updatedContentSignal sendNext:self.dataArray];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = ProductListViewModel_Signal_Type_GetDataFail;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithProductModels:(NSArray *)productModels
                        appending:(BOOL)appending
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [productModels enumerateObjectsUsingBlock:^(ProductListItemModel *itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
        ProductListItemViewModel *itemVM = [[ProductListItemViewModel alloc] initWithModel:itemModel];
        itemVM.score = itemModel.score;
        itemVM.cartType = self.cartType;
        [resultArray addObject:itemVM];
    }];
    if (appending) {
        self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
    }else{
        self.dataArray = [NSArray arrayWithArray:resultArray];
    }
}

#pragma mark -排序
- (void)orderByDefault
{
    self.sales_sort = nil;
    self.price_sort = nil;
    self.score_sort = nil;
    self.currentSignalType = ProductListViewModel_Signal_Type_LoadingInView;
    [self.updatedContentSignal sendNext:nil];
    [self getData];
}

- (void)orderBySale
{
    self.sales_sort = @(1);
    self.price_sort = nil;
    self.score_sort = nil;
    self.currentSignalType = ProductListViewModel_Signal_Type_LoadingInView;
    [self.updatedContentSignal sendNext:nil];
    [self getData];
}

- (void)orderByPrice:(BOOL)desc
{
    self.sales_sort = nil;
    if (self.cartType == 0) {
        self.price_sort = desc?@(1):@(0);
        self.score_sort = nil;
    }else{
        self.price_sort = nil;
        self.score_sort = desc?@(1):@(0);
    }

    self.currentSignalType = ProductListViewModel_Signal_Type_LoadingInView;
    [self.updatedContentSignal sendNext:nil];
    [self getData];
}

#pragma mark -列表相关
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellVMForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListItemViewModel *itemVM = [self.dataArray objectAtIndex:indexPath.row];
    GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:itemVM.productID
                                                                     goodsDetailType:self.cartType == 0?GoodsDetailType_Normal:GoodsDetailType_Store
                                                                   activity_flash_id:nil
                                                                 activity_bargain_id:nil
                                                                   activity_group_id:nil];
    self.currentSignalType = ProductListViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:detailVM];
}

#pragma mark -展示筛选
- (void)startToSift
{
    SiftListViewModel *siftVM = [[SiftListViewModel alloc] initWithGoods_cart_id:[self.goods_cat_id lyStringValue]
                                                                        cartType:[@(self.cartType) lyStringValue]
                                                                       min_score:[self.min_score lyStringValue]
                                                                       max_score:[self.max_score lyStringValue]];
    self.currentSignalType = ProductListViewModel_Signal_Type_ShowSift;
    [self.updatedContentSignal sendNext:siftVM];
}

@end
