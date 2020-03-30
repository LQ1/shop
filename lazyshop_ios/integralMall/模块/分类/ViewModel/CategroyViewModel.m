//
//  CategroyViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategroyViewModel.h"

#import "CategoryFirstItemViewModel.h"
#import "CategoryModel.h"

#import "CategoryService.h"

@interface CategroyViewModel()

@property (nonatomic,assign)CategroyViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)CategoryService *service;

@end

@implementation CategroyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [CategoryService new];
    }
    return self;
}

#pragma mark -获取数据
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getGoodsCategoryWithType:self.currentCategoryType] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithCategoryModels:x];
        self.currentSignalType = CategroyViewModel_Signal_Type_GetDataSuccess;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = CategroyViewModel_Signal_Type_GetDataFail;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}
// 处理数据
- (void)dealDataWithCategoryModels:(NSArray *)categoryModels
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [categoryModels enumerateObjectsUsingBlock:^(CategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        CategoryFirstItemViewModel *firstItemVM = [[CategoryFirstItemViewModel alloc] initWithCategoryModel:model];
        [resultArray addObject:firstItemVM];
    }];
    self.dataArray = [NSArray arrayWithArray:resultArray];
}

#pragma mark -列表相关
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CategoryFirstItemViewModel *)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryFirstItemViewModel *vm = [self.dataArray objectAtIndex:indexPath.row];
    return vm;
}
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(CategoryFirstItemViewModel *vm, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == idx) {
            if (!vm.selected) {
                vm.selected = YES;
            }
        }else{
            if (vm.selected) {
                vm.selected = NO;
            }
        }
    }];
}

#pragma mark -跳转商品列表
- (void)gotoProductListWithVM:(id)vm
{
    self.currentSignalType = CategroyViewModel_Signal_Type_GotoProductlist;
    [self.updatedContentSignal sendNext:vm];
}

#pragma mark -获取默认选中行数
- (NSIndexPath *)fetchDefaultSelectedIndexPath
{
    if (self.currentCategoryType == CategroyDataType_Integral) {
        return [NSIndexPath indexPathForRow:0 inSection:0];
    }else{
        __block NSInteger row = 0;
        @weakify(self);
        [self.dataArray enumerateObjectsUsingBlock:^(CategoryFirstItemViewModel *vm, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if ([vm.firstCategoryID integerValue] == [self.currentStoreGoodsCartID integerValue]) {
                row = idx;
                *stop = YES;
            }
        }];
        self.currentStoreGoodsCartID = nil;
        return [NSIndexPath indexPathForRow:row inSection:0];
    }
}

@end
