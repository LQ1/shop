//
//  ShippingAddressSelectViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressSelectViewModel.h"

#import "ShippingAddressSelectCellViewModel.h"
#import "ShippingAddressEidtViewModel.h"
#import "ShippingAddressService.h"
#import "ShippingAddressModel.h"

@interface ShippingAddressSelectViewModel()

@property (nonatomic,strong)ShippingAddressService *service;
@property (nonatomic,copy)NSString *userAddressID;

@end

@implementation ShippingAddressSelectViewModel

- (instancetype)initWithUserAddressID:(NSString *)userAddressID
{
    self = [super init];
    if (self) {
        self.service = [ShippingAddressService new];
        self.userAddressID = userAddressID;
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getAddressList] subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        @weakify(self);
        [array enumerateObjectsUsingBlock:^(ShippingAddressModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            ShippingAddressSelectCellViewModel *cellVM = [[ShippingAddressSelectCellViewModel alloc] initWithShippingAddressModel:model];
            if ([cellVM.shippingAddressID integerValue] == [self.userAddressID integerValue]) {
                cellVM.selected = YES;
            }else{
                cellVM.selected = NO;
            }
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

- (ShippingAddressSelectCellViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block ShippingAddressModel *addressModel = nil;
    [self.dataArray enumerateObjectsUsingBlock:^(ShippingAddressSelectCellViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            itemVM.selected = YES;
            addressModel = itemVM.model;
        }else{
            itemVM.selected = NO;
        }
    }];
    
    self.currentSignalType = ShippingAddressSelectViewModel_Signal_Type_ReloadData;
    [self.updatedContentSignal sendNext:nil];

    self.currentSignalType = ShippingAddressSelectViewModel_Signal_Type_SelectAddressSuccess;
    [self.updatedContentSignal sendNext:addressModel];
}

#pragma mark -新建地址
- (void)addAddress
{
    ShippingAddressEidtViewModel *vm = [[ShippingAddressEidtViewModel alloc] init];
    self.currentSignalType = ShippingAddressSelectViewModel_Signal_Type_GotoAddAddress;
    [self.updatedContentSignal sendNext:vm];
}

@end
