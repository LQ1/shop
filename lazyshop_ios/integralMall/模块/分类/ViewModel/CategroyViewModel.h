//
//  CategroyViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class CategoryFirstItemViewModel;

typedef NS_ENUM(NSInteger, CategroyViewModel_Signal_Type)
{
    CategroyViewModel_Signal_Type_TipLoading = 0,
    CategroyViewModel_Signal_Type_GetDataSuccess,
    CategroyViewModel_Signal_Type_GetDataFail,
    CategroyViewModel_Signal_Type_GotoProductlist
};

typedef NS_ENUM(NSInteger, CategroyDataType)
{
    CategroyDataType_Store = 0,
    CategroyDataType_Integral
};

@interface CategroyViewModel : BaseViewModel

@property (nonatomic,readonly)CategroyViewModel_Signal_Type currentSignalType;

@property (nonatomic,assign)CategroyDataType currentCategoryType;

@property (nonatomic,copy)NSString *currentStoreGoodsCartID;
/*
 *  获取数据
 */
- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CategoryFirstItemViewModel *)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 *  跳转商品列表
 */
- (void)gotoProductListWithVM:(id)vm;

/*
 *  获取默认选中位置
 */
- (NSIndexPath *)fetchDefaultSelectedIndexPath;

@end
