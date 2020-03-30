//
//  ShippingAddressManageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressManageViewModel.h"

#import "ShippingAddressManageCellViewModel.h"
#import "ShippingAddressEidtViewModel.h"

#import "ShippingAddressEidtViewModel.h"

#import "ShippingAddressService.h"

@interface ShippingAddressManageViewModel()

@property (nonatomic,strong)ShippingAddressService *service;

@end

@implementation ShippingAddressManageViewModel

#pragma mark -init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [ShippingAddressService new];
    }
    return self;
}

#pragma mark -get
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getAddressList] subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShippingAddressManageCellViewModel *cellVM = [[ShippingAddressManageCellViewModel alloc] initWithShippingAddressModel:obj];
            [resultArray addObject:cellVM];
        }];
        self.dataArray = [NSArray arrayWithArray:resultArray];
        [self.fetchListSuccessSignal sendNext:nil];
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

- (ShippingAddressManageCellViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

#pragma mark -操作
- (void)setDefaultAtRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressManageCellViewModel *cellVM = [self itemViewModelAtIndexPath:indexPath];
    if (cellVM.isDefault == NO) {
        @weakify(self);
        self.loading = YES;
        RACDisposable *disPos = [[self.service setDefaulAddressWithUser_address_id:[cellVM.shippingAddressID integerValue]] subscribeNext:^(id x) {
            @strongify(self);
            [self.tipLoadingSignal sendNext:@"设置成功"];
            self.currentSignalType = ShippingAddressManageViewModel_Singal_Type_GetData;
            [self.updatedContentSignal sendNext:nil];
        } error:^(NSError *error) {
            @strongify(self);
            [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
        }];
        [self addDisposeSignal:disPos];
    }
}

- (void)editAtRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressManageCellViewModel *cellVM = [self itemViewModelAtIndexPath:indexPath];
    ShippingAddressEidtViewModel *editVM = [[ShippingAddressEidtViewModel alloc] initWithShippingAddressModel:cellVM.model];
    self.currentSignalType = ShippingAddressManageViewModel_Singal_Type_GotoAddAddress;
    [self.updatedContentSignal sendNext:editVM];
}

- (void)deleteAtRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"确认删除"
                                                     titles:@[@"取消",@"确定"]
                                                      click:^(NSInteger index) {
                                                          @strongify(self);
                                                          if (index == 1) {
                                                              ShippingAddressManageCellViewModel *cellVM = [self itemViewModelAtIndexPath:indexPath];
                                                              self.loading = YES;
                                                              RACDisposable *disPos = [[self.service deleleAddressListWithUser_address_id:[cellVM.shippingAddressID integerValue]] subscribeNext:^(id x) {
                                                                  @strongify(self);
                                                                  [self.tipLoadingSignal sendNext:@"删除成功"];
                                                                  self.currentSignalType = ShippingAddressManageViewModel_Singal_Type_GetData;
                                                                  [self.updatedContentSignal sendNext:nil];
                                                              } error:^(NSError *error) {
                                                                  @strongify(self);
                                                                  [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
                                                              }];
                                                              [self addDisposeSignal:disPos];
                                                          }
                                                      }];
    [alert show];
}

#pragma mark -新建地址
- (void)addAddress
{
    ShippingAddressEidtViewModel *vm = [[ShippingAddressEidtViewModel alloc] init];
    self.currentSignalType = ShippingAddressManageViewModel_Singal_Type_GotoAddAddress;
    [self.updatedContentSignal sendNext:vm];
}

@end
