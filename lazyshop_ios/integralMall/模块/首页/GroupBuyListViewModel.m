//
//  GroupBuyListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GroupBuyListViewModel.h"

#import "HomeService.h"

#import "GroupBuyListItemCellViewModel.h"

#import "GoodsDetailViewModel.h"

@interface GroupBuyListViewModel()

@property (nonatomic,strong)HomeService *service;

@end

@implementation GroupBuyListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [HomeService new];
    }
    return self;
}

#pragma mark -getData
- (void)getData:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.dataArray.count];
    }
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchGroupBuyListWithPage:page] subscribeNext:^(NSArray *models) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GroupBuyListItemCellViewModel *vm = [[GroupBuyListItemCellViewModel alloc] initWithProductRowBaseModel:obj];
            [resultArray addObject:vm];
        }];
        if (refresh) {
            self.dataArray = [NSArray arrayWithArray:resultArray];
        }else{
            self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
        }
        [self.fetchListSuccessSignal sendNext:self.dataArray];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupBuyListItemCellViewModel *vm = [self cellVMForRowAtIndexPath:indexPath];
    GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:vm.productID
                                                                     goodsDetailType:GoodsDetailType_GroupBy
                                                                   activity_flash_id:nil
                                                                 activity_bargain_id:nil
                                                                   activity_group_id:vm.activity_group_id];
    self.currentSignalType = GroupBuyListViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:detailVM];
}

@end
