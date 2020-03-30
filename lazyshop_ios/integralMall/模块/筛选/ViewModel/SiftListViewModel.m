//
//  SiftListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListViewModel.h"

#import "SiftListSectionViewModel.h"
#import "SiftListItemViewModel.h"
#import "CategoryService.h"
#import "CategoryModel.h"

@interface SiftListViewModel()

@property (nonatomic,strong)CategoryService *service;

@property (nonatomic,assign)SiftListViewModelSignalType currentSignalType;

@property (nonatomic,copy)NSString *cartType;

@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation SiftListViewModel

- (instancetype)initWithGoods_cart_id:(NSString *)goods_cart_id
                             cartType:(NSString *)cartType
                            min_score:(NSString *)min_score
                            max_score:(NSString *)max_score
{
    self = [super init];
    if (self) {
        self.service = [CategoryService new];
        self.goods_cart_id = goods_cart_id;
        self.cartType = cartType;
        self.min_store = min_score;
        self.max_store = max_score;
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getGoodsCategoryWithType:[self.cartType integerValue]] subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        // 遍历1
        [array enumerateObjectsUsingBlock:^(CategoryModel *model1, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            NSMutableArray *itemVMs = [NSMutableArray array];
            // 遍历2
            [model1.child enumerateObjectsUsingBlock:^(CategoryModel *model2, NSUInteger idx, BOOL * _Nonnull stop) {
                // 遍历3
                [model2.child enumerateObjectsUsingBlock:^(CategoryModel *model3, NSUInteger idx, BOOL * _Nonnull stop) {
                    @strongify(self);
                    BOOL selected = [self.goods_cart_id integerValue] == model3.goods_cat_id;
                    SiftListItemViewModel *itemVM = [[SiftListItemViewModel alloc] initWithCategorySecondID:[NSString stringWithFormat:@"%ld",(long)model3.goods_cat_id] categorySecondName:model3.title selected:selected];
                    [itemVMs addObject:itemVM];
                }];
            }];
            // 添加全部
            BOOL secAllItemSelected = [self.goods_cart_id integerValue] == model1.goods_cat_id;
            SiftListItemViewModel *secAllItemVM = [[SiftListItemViewModel alloc] initWithCategorySecondID:[NSString stringWithFormat:@"%ld",(long)model1.goods_cat_id] categorySecondName:@"全部" selected:secAllItemSelected];
            [itemVMs insertObject:secAllItemVM atIndex:0];

            // 是否展开
            BOOL unfolded = ([self.goods_cart_id integerValue] == model1.goods_cat_id)||([itemVMs linq_any:^BOOL(SiftListItemViewModel *anyItemVM) {
                @strongify(self);
                return [self.goods_cart_id integerValue] == [anyItemVM.categorySecondID integerValue] && anyItemVM.selected == YES;
            }]);
            SiftListSectionViewModel *sectionVM = [[SiftListSectionViewModel alloc] initWithCategoryFirstID:[NSString stringWithFormat:@"%ld",(long)model1.goods_cat_id] categoryFirstName:model1.title unfolded:unfolded itemViewModels:itemVMs];
            [resultArray addObject:sectionVM];
            self.dataArray = [NSArray arrayWithArray:resultArray];
            self.currentSignalType = SiftListViewModelSignalType_FetchDataSuccess;
            [self.updatedContentSignal sendNext:nil];
        }];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = SiftListViewModelSignalType_FetchDataFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -table
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    SiftListSectionViewModel *secVM = [self.dataArray objectAtIndex:section];
    return secVM.UIHeight;
}

- (void)clickHeaderInSection:(NSInteger)section
{
    SiftListSectionViewModel *secVM = [self.dataArray objectAtIndex:section];
    secVM.unfolded = !secVM.unfolded;
}

- (id)viewModelForHeaderInSection:(NSInteger)section
{
    SiftListSectionViewModel *secVM = [self.dataArray objectAtIndex:section];
    return secVM;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    SiftListSectionViewModel *secVM = [self.dataArray objectAtIndex:section];
    if (secVM.unfolded) {
        return secVM.childViewModels.count;
    }
    return 0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiftListItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    return itemVM.UIHeight;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiftListSectionViewModel *secVM = [self.dataArray objectAtIndex:indexPath.section];
    return [secVM.childViewModels objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    [self.dataArray enumerateObjectsUsingBlock:^(SiftListSectionViewModel *sectionVM, NSUInteger idx1, BOOL * _Nonnull stop) {
        [sectionVM.childViewModels enumerateObjectsUsingBlock:^(SiftListItemViewModel *itemVM, NSUInteger idx2, BOOL * _Nonnull stop) {
            @strongify(self);
            if (indexPath.section == idx1 && indexPath.row == idx2) {
                self.goods_cart_id = itemVM.categorySecondID;
                itemVM.selected = YES;
            }else{
                itemVM.selected = NO;
            }
        }];
    }];
}

- (void)clearAllRowsSelected
{
    [self.dataArray enumerateObjectsUsingBlock:^(SiftListSectionViewModel *sectionVM, NSUInteger idx, BOOL * _Nonnull stop) {
        [sectionVM.childViewModels enumerateObjectsUsingBlock:^(SiftListItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
            itemVM.selected = NO;
        }];
    }];
    self.goods_cart_id = nil;
    self.min_store = nil;
    self.max_store = nil;
}

- (void)completeSift
{
    self.currentSignalType = SiftListViewModelSignalType_CompleteSift;
    [self.updatedContentSignal sendNext:self.goods_cart_id];
}

@end
