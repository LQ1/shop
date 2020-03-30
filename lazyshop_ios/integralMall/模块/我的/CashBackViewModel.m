//
//  CashBackViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackViewModel.h"

#import "CashBackSectionViewModel.h"
#import "CashBackItemViewModel.h"

#import "MineService.h"
#import "CashBackModel.h"

@interface CashBackViewModel()

@property (nonatomic,strong) MineService *service;

@end

@implementation CashBackViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getMineRebateList] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithCashBackModels:x];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

- (void)dealDataWithCashBackModels:(NSArray *)cashBackModels
{
    NSMutableArray *sectionVMs = [NSMutableArray array];
    [cashBackModels enumerateObjectsUsingBlock:^(CashBackModel *cashBackModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CashBackSectionViewModel *secVM = [CashBackSectionViewModel new];
        secVM.order_detail_id = cashBackModel.order_detail_id;
        secVM.order_id = cashBackModel.order_id;
        secVM.productName = cashBackModel.goods_title;
        // 改成了根据订单商品的货仓自动确定返现货仓
        secVM.storeID = [cashBackModel.storehouse_id lyStringValue];
        secVM.storeName = cashBackModel.storehouse_name;
        NSMutableArray *itemVMs = [NSMutableArray array];
        [cashBackModel.rebate_code enumerateObjectsUsingBlock:^(CashBackRebateCodeModel *codeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CashBackItemViewModel *itemVM = [CashBackItemViewModel new];
            // 是否收起展示
            itemVM.is_current = [codeModel.is_current boolValue];
            // 期数、金额
            itemVM.cashBackIssue = codeModel.rebate_period;
            itemVM.cashBackMoney = codeModel.amount;
            itemVM.can_use_at = codeModel.can_use_at;
            // 返现码、返利码状态
            if ([cashBackModel.shop_id integerValue]>0) {
                // 已绑定店铺
                if ([codeModel.can_use integerValue] == 1) {
                    // 未使用
                    itemVM.state = CashBackState_NotUse;
                    itemVM.cashBackCode = codeModel.code;
                }else{
                    if (codeModel.use_at.length) {
                        // 已使用
                        itemVM.state = CashBackState_Used;
                        itemVM.cashBackCode = codeModel.code;
                    }else{
                        // 不可用
                        itemVM.state = CashBackState_Invalid;
                        if (itemVM.can_use_at.length) {
                            itemVM.cashBackCode = [NSString stringWithFormat:@"%@后才可以查看返现码",itemVM.can_use_at];
                        }else{
                            NSString *prefix = @"上一期使用";
                            if (idx == 0) {
                                prefix = @"订单完成";
                            }
                            itemVM.cashBackCode = [NSString stringWithFormat:@"%@%@天后才可以查看返现码",prefix,cashBackModel.rebate_days];
                        }
                    }
                }
            }else{
                // 未绑定店铺
                itemVM.state = CashBackState_Invalid;
                itemVM.cashBackCode = @"未选择关联店铺";
            }
            [itemVMs addObject:itemVM];
        }];
        secVM.childViewModels = [NSArray arrayWithArray:itemVMs];
        [sectionVMs addObject:secVM];
    }];
    
    self.dataArray = [NSArray arrayWithArray:sectionVMs];
    [self.fetchListSuccessSignal sendNext:nil];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)sectionViewModelInSection:(NSInteger)section
{
    return [self.dataArray objectAtIndex:section];
}

- (void)clickFooterInSection:(NSInteger)section
{
    CashBackSectionViewModel *sectionVM = [self sectionViewModelInSection:section];
    sectionVM.unfold = !sectionVM.unfold;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    CashBackSectionViewModel *sectionVM = [self sectionViewModelInSection:section];
    if (sectionVM.childViewModels.count>1) {
        if (sectionVM.unfold) {
            return sectionVM.childViewModels.count;
        }else{
            return 1;
        }
    }
    return sectionVM.childViewModels.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashBackItemViewModel *item = [self cellViewModelForRowAtIndexPath:indexPath];
    return [item cellHeight];
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashBackSectionViewModel *sectionVM = [self sectionViewModelInSection:indexPath.section];
    if (sectionVM.unfold) {
        return [sectionVM.childViewModels objectAtIndex:indexPath.row];
    }else{
        CashBackItemViewModel *currentItemVM =[sectionVM.childViewModels linq_where:^BOOL(CashBackItemViewModel *itemVM) {
            return itemVM.is_current == YES;
        }].linq_firstOrNil;
        if (!currentItemVM) {
            currentItemVM = sectionVM.childViewModels.linq_firstOrNil;
        }
        return currentItemVM;
    }
}

#pragma mark -跳转
- (void)gotoOrderDetailWithVM:(id)vm
{
    self.currentSignalType = CashBackViewModel_Signal_Type_GotoOrderDetail;
    [self.updatedContentSignal sendNext:vm];
}

- (void)gotoBindShopWithVM:(id)vm
{
    self.currentSignalType = CashBackViewModel_Signal_Type_GotoBindShop;
    [self.updatedContentSignal sendNext:vm];
}

@end
