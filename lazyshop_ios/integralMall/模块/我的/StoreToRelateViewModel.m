//
//  StoreToRelateViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreToRelateViewModel.h"

#import "StoreListItemViewModel.h"
#import "RelateScoreService.h"
#import "ScoreItemModel.h"

@interface StoreToRelateViewModel()

@property (nonatomic,copy)NSString *storeID;
@property (nonatomic,strong)RelateScoreService *service;

@end

@implementation StoreToRelateViewModel

- (instancetype)initWithStoreID:(NSString *)storeID
{
    self = [super init];
    if (self) {
        self.storeID = storeID;
        self.service = [RelateScoreService new];
    }
    return self;
}

#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service relateShopDetailWithShop_id:self.storeID] subscribeNext:^(ScoreItemModel *model) {
        @strongify(self);
        self->_itemViewModel = [StoreListItemViewModel new];
        self->_itemViewModel.storeID = model.shop_id;
        self->_itemViewModel.storeName = model.shop_name;
        self->_itemViewModel.storeCategoryName = model.shop_describe;
        self->_itemViewModel.storeImgUrl = model.thumb_image;
        self->_itemViewModel.hideRightArrow = YES;
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -关联店铺
- (void)relate
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service bindScoreWithShop_id:self.storeID] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = StoreToRelateViewModel_Signal_Type_RelateSuccess;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];

}

@end
