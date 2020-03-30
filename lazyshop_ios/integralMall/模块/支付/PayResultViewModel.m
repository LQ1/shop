//
//  PayResultViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PayResultViewModel.h"

#import "ProductListService.h"
#import "HomeChosenCellViewModel.h"
#import "ProductListItemModel.h"
#import "ProductListItemViewModel.h"

#import "OrderDetailViewModel.h"

@interface PayResultViewModel()

@property (nonatomic,strong) ProductListService *service;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) HomeChosenCellViewModel *chosenViewModel;
@property (nonatomic,copy) NSString *orderID;

@end

@implementation PayResultViewModel

- (instancetype)initWithPaySuccess:(BOOL)paySuccess
                       payMentType:(PayMentType)paymentType
                          payValue:(NSString *)payValue
                          order_id:(NSString *)orderID
{
    self = [super init];
    if (self) {
        self.paySuccess = paySuccess;
        self.payMentType = paymentType;
        self.payValue = payValue;
        self.orderID = orderID;
        self.service = [ProductListService new];
    }
    return self;
}

// 获取商品列表
- (void)getData:(BOOL)refresh
{
    if (refresh) {
        self.oldDataCount = 0;
    }
    
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:[self.chosenViewModel itemCountAtSection:0]];
    }
    // 获取商品列表
    @weakify(self);
    RACDisposable *productListDisPos = [[self.service getRecommendProductListWithPage:page
                                                                                 type:@"0"] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(ProductListItemModel *productListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductListItemViewModel *itemVM = [[ProductListItemViewModel alloc] initWithModel:productListModel];
            [resultArray addObject:itemVM];
        }];
        if (refresh) {
            self.chosenViewModel = [[HomeChosenCellViewModel alloc] initWithItemModels:resultArray];
            self.chosenViewModel.usedForRecommend = YES;
        }else{
            self.chosenViewModel.itemModels = [self.chosenViewModel.itemModels arrayByAddingObjectsFromArray:resultArray];
        }
        if (refresh) {
            self.dataArray = @[self.chosenViewModel];
        }else{
            [self.chosenViewModel resetCellHeight];
        }
        self.currentSignalType = PayResultViewModel_SignalType_FetchGoodsSuccess;
        [self.updatedContentSignal sendNext:self.chosenViewModel.itemModels];
        
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = PayResultViewModel_SignalType_FetchGoodsFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:productListDisPos];
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

#pragma mark -跳转商品详情
// 商品详情
- (void)gotoGoodsDetailWithVM:(id)vm
{
    self.currentSignalType = PayResultViewModel_SignalType_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:vm];
}
// 查看订单/重新支付
- (void)checkBtnClick
{
    if (self.paySuccess) {
        // 查看订单
        OrderDetailViewModel *orderVM = [[OrderDetailViewModel alloc] initWithOrderID:self.orderID orderTitle:nil];
        self.currentSignalType = PayResultViewModel_SignalType_CheckOrder;
        [self.updatedContentSignal sendNext:orderVM];
    }else{
        // 重新支付
        self.currentSignalType = PayResultViewModel_SignalType_PayAgain;
        [self.updatedContentSignal sendNext:nil];
    }
}

@end
