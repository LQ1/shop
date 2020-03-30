//
//  CashBackHistoryViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackHistoryViewModel.h"

#import "CashBackItemViewModel.h"

#import "MineService.h"
#import "CashBackHistoryModel.h"

@interface CashBackHistoryViewModel()

@property (nonatomic,strong) MineService *service;

@end

@implementation CashBackHistoryViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
    }
    return self;
}

- (void)getData:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.dataArray.count];
    }

    @weakify(self);
    RACDisposable *disPos = [[self.service getRebateHistoryWithPage:page] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(CashBackHistoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CashBackItemViewModel *itemVM = [CashBackItemViewModel new];
            itemVM.cashBackIssue = obj.rebate_period;
            itemVM.cashBackMoney = obj.user_money;
            itemVM.state = CashBackState_Used;
            itemVM.cashBackCode = obj.code;
            itemVM.isHistoryItem = YES;
            itemVM.cashBackDate = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_at] format:@"yyyy-MM-dd"];
            itemVM.cashBackTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.use_at] format:@"mm:hh"];
            itemVM.cashBackTip = obj.use_type;
            [resultArray addObject:itemVM];
        }];
        if (refresh) {
            self.dataArray = [NSArray arrayWithArray:resultArray];
        }else{
            self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
        }
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

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.section];
}

@end
