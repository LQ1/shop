//
//  StoreDetailViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreDetailViewModel.h"

#import "StoreListItemViewModel.h"
#import "StoreDeailTextCellViewModel.h"
#import "StoreListItemCell.h"

#import "RelateScoreService.h"
#import "ScoreItemModel.h"

@interface StoreDetailViewModel()

@property (nonatomic,copy)NSString *storeID;
@property (nonatomic,copy)NSString *shop_user_id;
@property (nonatomic,strong)RelateScoreService *service;

@end

@implementation StoreDetailViewModel

- (instancetype)initWithStoreID:(NSString *)storeID
                   shop_user_id:(NSString *)shop_user_id
{
    self = [super init];
    if (self) {
        self.storeID = storeID;
        self.shop_user_id = shop_user_id;
        self.service = [RelateScoreService new];
    }
    return self;
}
#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getMyScoreDetailWithShop_id:self.storeID] subscribeNext:^(ScoreItemModel *model) {
        @strongify(self);
        // 基本信息
        StoreListItemViewModel *itemVM = [StoreListItemViewModel new];
        itemVM.storeID = model.shop_id;
        itemVM.storeCategoryName = model.shop_describe;
        itemVM.storeName = model.shop_name;
        itemVM.storeImgUrl = model.thumb_image;
        itemVM.hideRightArrow = YES;
        
        LYItemUIBaseViewModel *secVM1 = [LYItemUIBaseViewModel new];
        secVM1.childViewModels = @[itemVM];
        
        // 会员等级
        StoreDeailTextCellViewModel *myVip = [StoreDeailTextCellViewModel new];
        myVip.leftTitle = @"我的会员等级";
        myVip.rightTitle = model.user_rank;
        myVip.rightTitleColor = APP_MainColor;
        
        LYItemUIBaseViewModel *secVM2 = [LYItemUIBaseViewModel new];
        secVM2.childViewModels = @[myVip];
        
        // 地址
        NSMutableArray *addresses = [NSMutableArray array];
        [model.shop_address enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            StoreDeailTextCellViewModel *addressVM = [StoreDeailTextCellViewModel new];
            addressVM.leftTitle = [NSString stringWithFormat:@"地址%ld",(long)idx+1];
            addressVM.rightTitle = obj;
            [addresses addObject:addressVM];
        }];
        LYItemUIBaseViewModel *secVM3 = [LYItemUIBaseViewModel new];
        secVM3.childViewModels = [NSArray arrayWithArray:addresses];
        
        self.dataArray = @[secVM1,secVM2,secVM3];
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:section];
    return secVM.childViewModels.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:indexPath.section];
    LYItemUIBaseViewModel *itemVM = [secVM.childViewModels objectAtIndex:indexPath.row];
    if ([itemVM isKindOfClass:[StoreListItemViewModel class]]) {
        return StoreListItemCellHeight;
    }else if ([itemVM isKindOfClass:[StoreDeailTextCellViewModel class]]){
        return [((StoreDeailTextCellViewModel *)itemVM) cellHeight];
    }
    return 0.001f;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *secVM = [self.dataArray objectAtIndex:indexPath.section];
    LYItemUIBaseViewModel *itemVM = [secVM.childViewModels objectAtIndex:indexPath.row];
    return itemVM;
}

@end
