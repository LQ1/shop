//
//  SelectStoreViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SelectStoreViewModel.h"

#import "RelateScoreService.h"
#import "ScoreItemModel.h"
#import "SelectStoreItemViewModel.h"

@interface SelectStoreViewModel()

@property (nonatomic,strong)RelateScoreService *service;
@property (nonatomic,copy)NSString *order_detail_id;

@end

@implementation SelectStoreViewModel

- (instancetype)initWithOrder_detail_id:(NSString *)orderDetailID
{
    self = [super init];
    if (self) {
        _showToScanSignal = [[RACSubject subject] setNameWithFormat:@"%@ showToScanSignal", self.class];
        _bindShopSuccessSignal = [[RACSubject subject] setNameWithFormat:@"%@ bindShopSuccessSignal", self.class];
        self.service = [RelateScoreService new];
        self.order_detail_id = orderDetailID;
    }
    return self;
}

#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getMyScoreList] subscribeNext:^(NSArray *x) {
        @strongify(self);
        if ([x count]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            [x enumerateObjectsUsingBlock:^(ScoreItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SelectStoreItemViewModel *itemVM = [SelectStoreItemViewModel new];
                itemVM.storeID = obj.shop_id;
                itemVM.user_shop_id = obj.shop_user_id;
                itemVM.storeCategoryName = obj.shop_describe;
                itemVM.storeName = obj.shop_name;
                itemVM.storeImgUrl = obj.thumb_image;
                [resultArray addObject:itemVM];
            }];
            self.dataArray = [NSArray arrayWithArray:resultArray];
            [self.fetchListSuccessSignal sendNext:nil];
        }else{
            [self.showToScanSignal sendNext:@"您还没有关联店铺\n快去扫一扫关联店铺吧!"];
        }
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -列表
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.section];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(SelectStoreItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.section == idx) {
            itemVM.selected = YES;
        }else{
            itemVM.selected = NO;
        }
    }];
}

#pragma mark -绑定店铺
- (void)bindSelectShop
{
    SelectStoreItemViewModel *selectedVM = [self.dataArray linq_where:^BOOL(SelectStoreItemViewModel *itemVM) {
        return itemVM.selected == YES;
    }].linq_firstOrNil;
    if (!selectedVM) {
        [self.tipLoadingSignal sendNext:@"请选择一个店铺"];
    }else{
        @weakify(self);
        self.loading = YES;
        RACDisposable *disPos = [[self.service bindRebateScoreWithShop_id:selectedVM.storeID order_detail_id:self.order_detail_id] subscribeNext:^(id x) {
            @strongify(self);
            self.loading = NO;
            [self.bindShopSuccessSignal sendNext:nil];
        } error:^(NSError *error) {
            @strongify(self);
            self.loading = NO;
            [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
        }];
        [self addDisposeSignal:disPos];
    }
}

@end
