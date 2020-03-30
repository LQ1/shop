//
//  RelateStoreViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RelateStoreViewModel.h"

#import "StoreListItemViewModel.h"
#import "StoreDetailViewModel.h"

#import "RelateScoreService.h"
#import "ScoreItemModel.h"

@interface RelateStoreViewModel()

@property (nonatomic,strong)RelateScoreService *service;

@end

@implementation RelateStoreViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showToScanSignal = [[RACSubject subject] setNameWithFormat:@"%@ showToScanSignal", self.class];
        self.service = [RelateScoreService new];
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
                StoreListItemViewModel *itemVM = [StoreListItemViewModel new];
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
    StoreListItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    StoreDetailViewModel *vm = [[StoreDetailViewModel alloc] initWithStoreID:itemVM.storeID
                                                                shop_user_id:itemVM.user_shop_id];
    
    self.currentSignalType = RelateStoreViewModel_Signal_Type_GotoStoreDetail;
    [self.updatedContentSignal sendNext:vm];
}

@end
