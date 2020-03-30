//
//  ShoppingCartViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger, ShoppingCartViewModel_Signal_Type)
{
    ShoppingCartViewModel_Signal_Type_TipLoading = 0,
    ShoppingCartViewModel_Signal_Type_GetCartListSuccess,
    ShoppingCartViewModel_Signal_Type_GetCartListFailed,
    ShoppingCartViewModel_Signal_Type_NeedReloadView,
    ShoppingCartViewModel_Signal_Type_NeedPullToRefresh,
    ShoppingCartViewModel_Signal_Type_GotoConfirmOrder,
    ShoppingCartViewModel_Signal_Type_NeedLogin,
    ShoppingCartViewModel_Signal_Type_GetRecommentSuccess,
    ShoppingCartViewModel_Signal_Type_GetRecommentFailed,
    ShoppingCartViewModel_Signal_Type_GotoGoodsDetail,
    ShoppingCartViewModel_Signal_Type_GotoHomePage
};

@interface ShoppingCartViewModel : BaseViewModel

@property (nonatomic,assign)NSInteger oldDataCount;

@property (nonatomic,readonly)ShoppingCartViewModel_Signal_Type currentSignalType;

@property (nonatomic,readonly )BOOL editting;
@property (nonatomic,readonly )BOOL empty;

- (void)getData;
- (void)getRecommentd:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)sectionViewModelInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)gotoGoodsDetailAtIndexPath:(NSIndexPath *)indexPath;
- (void)revalCheckedAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cartIDAtIndexPath:(NSIndexPath *)indexPath;

/*
 *  反置编辑
 */
- (void)revalEditing;

/*
 *  选中个数
 */
- (NSInteger)selectedGoodsNumber;
/*
 *  总价格
 */
- (NSString *)totalPrice;
/*
 *  是否全选
 */
- (BOOL)checkAllSelected;
/*
 *  反置全选状态
 */
- (void)revalAllCheck;
/*
 *  去结算
 */
- (void)gotoPay;
/*
 *  删除选中
 */
- (void)deleteSelectGoods;

/*
 *  跳转商品详情
 */
- (void)gotoGoodsDetailWithVM:(id)vm;
/*
 *  跳转首页
 */
- (void)gotoHomePage;

@end
