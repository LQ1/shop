//
//  HomeViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger, HomeViewModel_Signal_Type)
{
    HomeViewModel_Signal_Type_TipLoading = 0,
    HomeViewModel_GetDataSuccess,
    HomeViewModel_GetProductsSuccess,
    HomeViewModel_GetDataFail,
    HomeViewModel_GetProductsFailed,
    HomeViewModel_GotoSecKillList,
    HomeViewModel_GotoGroupBuyList,
    HomeViewModel_GotoBargainList,
    HomeViewModel_GotoGoodsDetail,
    HomeViewModel_GotoProductList,
    HomeViewModel_GotoScoreGoods,
    HomeViewModel_GotoJoinPartner,
};

@interface HomeViewModel : BaseViewModel

@property (nonatomic,assign)NSInteger oldDataCount;

@property (nonatomic,readonly)HomeViewModel_Signal_Type currentSignalType;

/*
 *  获取数据
 */
- (void)getData;
- (void)getGoodsListRefresh:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)gotoSecKillList;
- (void)gotoGroupBuyList;
- (void)gotoBargainList;
- (void)gotoGoodsDetailWithVM:(id)vm;
// 商品列表
- (void)gotoProductListWithVM:(id)vm;
// 积分商品
- (void)gotoScoreGoods;
- (void)gotoJoinParnter;
@end
