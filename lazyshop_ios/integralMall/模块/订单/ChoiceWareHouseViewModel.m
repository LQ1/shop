//
//  ChoiceWareHouseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseViewModel.h"

#import "ChoiceWareHouseItemViewModel.h"
#import "ChoiceWareHouseService.h"
#import "ChoiceWareHouseItemModel.h"

@interface ChoiceWareHouseViewModel()

@property (nonatomic,strong)ChoiceWareHouseService *service;
@property (nonatomic,copy)NSString *wareHouseID;

@end

@implementation ChoiceWareHouseViewModel

- (instancetype)initWithWareHouseID:(NSString *)wareHouseID
{
    self = [super init];
    if (self) {
        self.service = [ChoiceWareHouseService new];
        self.wareHouseID = wareHouseID;
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getWareHouseList] subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        @weakify(self);
        [array enumerateObjectsUsingBlock:^(ChoiceWareHouseItemModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            ChoiceWareHouseItemViewModel *cellVM = [[ChoiceWareHouseItemViewModel alloc] initWithChoiceWareHouseItemModel:model];
            if ([cellVM.wareHouseID integerValue] == [self.wareHouseID integerValue]) {
                cellVM.checked = YES;
            }else{
                cellVM.checked = NO;
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

- (ChoiceWareHouseItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block ChoiceWareHouseItemModel *houseModel = nil;
    [self.dataArray enumerateObjectsUsingBlock:^(ChoiceWareHouseItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            itemVM.checked = YES;
            houseModel = itemVM.model;
        }else{
            itemVM.checked = NO;
        }
    }];
    
    self.currentSignalType = ChoiceWareHouseViewModel_Signal_Type_ReloadData;
    [self.updatedContentSignal sendNext:nil];
    
    self.currentSignalType = ChoiceWareHouseViewModel_Signal_Type_SelectHouseSuccess;
    [self.updatedContentSignal sendNext:houseModel];
}

@end
