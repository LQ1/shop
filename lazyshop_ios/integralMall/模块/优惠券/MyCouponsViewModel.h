//
//  MyCouponsViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@class CouponItemViewModel;

typedef NS_ENUM(NSInteger, MyCouponsViewModel_Signal_Type)
{
    MyCouponsViewModel_Signal_Type_GetDataSuccess = 0,
    MyCouponsViewModel_Signal_Type_GetDataFailed,
    MyCouponsViewModel_Signal_Type_GotoProductList
};

@interface MyCouponsViewModel : LYBaseViewModel

/*
 *  是否失效券
 */
@property (nonatomic,assign)BOOL inValidCouponDataSource;

/*
 *  头视图数据
 */
@property (nonatomic,strong)NSArray *switchItemViewModels;

- (instancetype)initWithInValidSelected:(BOOL)inValidSelected;

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CouponItemViewModel *)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)useCouponAtIndexPath:(NSIndexPath *)indexPath;

@end
