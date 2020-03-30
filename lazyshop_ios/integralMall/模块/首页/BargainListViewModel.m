//
//  BargainListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BargainListViewModel.h"

#import "HomeService.h"

#import "BargainListItemCellViewModel.h"

#import "GoodsDetailViewModel.h"

@interface BargainListViewModel()

@property (nonatomic,strong)HomeService *service;

@end

@implementation BargainListViewModel

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
    RACDisposable *disPos = [[self.service fetchBargainListWithPage:page] subscribeNext:^(NSArray *models) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BargainListItemCellViewModel *vm = [[BargainListItemCellViewModel alloc] initWithProductRowBaseModel:obj];
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
    BargainListItemCellViewModel *vm = [self cellVMForRowAtIndexPath:indexPath];
    GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:vm.productID
                                                                     goodsDetailType:GoodsDetailType_Bargain
                                                                   activity_flash_id:nil
                                                                 activity_bargain_id:vm.activity_bargain_id
                                                                   activity_group_id:nil];
    self.currentSignalType = BargainListViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:detailVM];
}

@end
