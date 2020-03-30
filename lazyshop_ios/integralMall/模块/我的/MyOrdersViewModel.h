//
//  MyOrdersViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,MyOrdersViewModel_Signal_Type)
{
    MyOrdersViewModel_Signal_Type_FetchListSuccess = 0,
    MyOrdersViewModel_Signal_Type_FetchListFailed,
    MyOrdersViewModel_Signal_Type_GotoOrderDetail,
    MyOrdersViewModel_Signal_Type_ReGetData,
    MyOrdersViewModel_Signal_Type_TipLoading,
    MyOrdersViewModel_Signal_Type_GotoPayment
};

@interface MyOrdersViewModel : BaseViewModel

@property (nonatomic, assign) MyOrdersViewModel_Signal_Type currentSignalType;

@property (nonatomic, readonly) NSArray *dataArray;

- (instancetype)initWithOrderStatus:(OrderStatus)orderStatus;

/*
 *  获取头部显示
 */
- (NSArray *)fetchOrderTypeViewModels;

/*
 *  切换显示
 */
- (void)changeToListWithType:(OrderStatus)orderStatus;

/*
 *  获取数据
 */
- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)sectionVMInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteOrderInSection:(NSInteger)section;
- (void)confirmOrderInSection:(NSInteger)section;
- (void)cancelOrderInSection:(NSInteger)section;
- (void)payOrderInSection:(NSInteger)section;

@end
