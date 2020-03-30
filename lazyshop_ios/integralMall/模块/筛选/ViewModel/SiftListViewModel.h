//
//  SiftListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,SiftListViewModelSignalType)
{
    SiftListViewModelSignalType_FetchDataSuccess = 0,
    SiftListViewModelSignalType_FetchDataFailed,
    SiftListViewModelSignalType_TipLoading,
    SiftListViewModelSignalType_CompleteSift
};

@interface SiftListViewModel : BaseViewModel

@property (nonatomic,readonly)SiftListViewModelSignalType currentSignalType;

@property (nonatomic,readonly)NSString *cartType;
@property (nonatomic,copy)NSString *goods_cart_id;
@property (nonatomic,copy)NSString *min_store;
@property (nonatomic,copy)NSString *max_store;

- (instancetype)initWithGoods_cart_id:(NSString *)goods_cart_id
                             cartType:(NSString *)cartType
                            min_score:(NSString *)min_score
                            max_score:(NSString *)max_score;

- (void)getData;

- (NSInteger)numberOfSections;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (void)clickHeaderInSection:(NSInteger)section;
- (id)viewModelForHeaderInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)clearAllRowsSelected;

- (void)completeSift;

@end
