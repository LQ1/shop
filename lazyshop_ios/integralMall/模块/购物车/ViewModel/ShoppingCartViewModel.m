//
//  ShoppingCartViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartViewModel.h"

#import "ShoppingCartItemModel.h"
#import "ShoppingCartItemViewModel.h"
#import "ShoppingCartEmptyCellViewModel.h"
#import "ShoppingCartSecViewMdoel.h"

#import "ProductListService.h"
#import "HomeChosenCellViewModel.h"
#import "ProductListItemViewModel.h"
#import "ProductListItemModel.h"

#import "ConfirmOrderViewModel.h"
#import "GoodsDetailViewModel.h"

@interface ShoppingCartViewModel()

@property (nonatomic,assign)ShoppingCartViewModel_Signal_Type currentSignalType;

@property (nonatomic,strong) ProductListService *productService;
@property (nonatomic,strong) HomeChosenCellViewModel *chosenViewModel;

@property (nonatomic,assign )BOOL editting;
@property (nonatomic,assign )BOOL empty;

@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation ShoppingCartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.productService = [ProductListService new];
    }
    return self;
}

- (void)getData
{
    if (![AccountService shareInstance].isLogin) {
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedLogin;
        [self.updatedContentSignal sendNext:nil];
        return;
    }
    @weakify(self);
    RACDisposable *disPos = [[[ShoppingCartService sharedInstance] fetchCartList] subscribeNext:^(id x) {
        @strongify(self);
        [self dealDataWithModels:x];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GetCartListFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

// 处理数据
- (void)dealDataWithModels:(NSArray *)models
{
    if (models.count>0) {
        self.empty = NO;
        // 购物车内有数据 展示购物车列表
        NSMutableArray *resultArray = [NSMutableArray array];
        
        [models enumerateObjectsUsingBlock:^(ShoppingCartItemModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            ShoppingCartItemViewModel *itemVM = [ShoppingCartItemViewModel new];
            itemVM.goods_id = model.goods_id;
            itemVM.goods_cart_id = [model.goods_cart_id lyStringValue];
            itemVM.productID = model.goods_id;
            itemVM.productName = model.title;
            itemVM.productImgUrl = model.thumb;
            itemVM.productSkuString = model.attr_values;
            itemVM.productPrice = model.price;
            itemVM.productQuantity = [model.quantity integerValue];
            itemVM.paySelected = YES;
            itemVM.underCart = [model.status integerValue]==0?YES:NO;
            //[model.stock integerValue]>0?NO:YES
            itemVM.outStock = NO;
            // 观察数量变化刷新价格变化
            @weakify(self);
            [[RACObserve(itemVM, productQuantity) distinctUntilChanged] subscribeNext:^(id x) {
                @strongify(self);
                self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedReloadView;
                [self.updatedContentSignal sendNext:nil];
            }];
            
            ShoppingCartSecViewMdoel *productSectionVM = [[ShoppingCartSecViewMdoel alloc] initWithHeight:10.f childViewModels:@[itemVM]];
            
            [resultArray addObject:productSectionVM];
        }];
        
        self.dataArray = [NSArray arrayWithArray:resultArray];
        
        // 映射编辑状态
        [self mapEdittingState];
        
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GetCartListSuccess;
        [self.updatedContentSignal sendNext:nil];
    }else{
        self.empty = YES;
        // 购物车内没有数据 展示空空如也 和 为你推荐
        ShoppingCartEmptyCellViewModel *emptyCellVM = [ShoppingCartEmptyCellViewModel new];
        ShoppingCartSecViewMdoel *emptySectionVM = [[ShoppingCartSecViewMdoel alloc] initWithHeight:0.0001 childViewModels:@[emptyCellVM]];
        
        self.dataArray = @[emptySectionVM];
        
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GetCartListSuccess;
        [self.updatedContentSignal sendNext:nil];
    }
    // 获取为你推荐
    [self getRecommentd:YES];
}
// 获取为你推荐
- (void)getRecommentd:(BOOL)refresh
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
    RACDisposable *productListDisPos = [[self.productService getRecommendProductListWithPage:page
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
            ShoppingCartSecViewMdoel *recommentSectionVM = [[ShoppingCartSecViewMdoel alloc] initWithHeight:0.0001 childViewModels:@[self.chosenViewModel]];
            self.dataArray = [self.dataArray arrayByAddingObject:recommentSectionVM];
        }else{
            [self.chosenViewModel resetCellHeight];
        }
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GetRecommentSuccess;
        [self.updatedContentSignal sendNext:self.chosenViewModel.itemModels];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GetRecommentFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:productListDisPos];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)sectionViewModelInSection:(NSInteger)section
{
    return [self.dataArray objectAtIndex:section];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    LYItemUIBaseViewModel *sectionVM = [self sectionViewModelInSection:section];
    return sectionVM.childViewModels.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *sectionVM = [self sectionViewModelInSection:indexPath.section];
    return [sectionVM.childViewModels objectAtIndex:indexPath.row];
}

- (void)gotoGoodsDetailAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isProductCellAtIndexPath:indexPath]) {
        ShoppingCartItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
        GoodsDetailViewModel *detailVM = [[GoodsDetailViewModel alloc] initWithProductID:itemVM.goods_id goodsDetailType:GoodsDetailType_Normal activity_flash_id:nil activity_bargain_id:nil activity_group_id:nil];
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_GotoGoodsDetail;
        [self.updatedContentSignal sendNext:detailVM];
    }
}

- (void)revalCheckedAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isProductCellAtIndexPath:indexPath]) {
        ShoppingCartItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
        if (itemVM.editting) {
            itemVM.editSelected = !itemVM.editSelected;
        }else{
            itemVM.paySelected = !itemVM.paySelected;
        }
        
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedReloadView;
        [self.updatedContentSignal sendNext:nil];
    }
}

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self isProductCellAtIndexPath:indexPath];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isProductCellAtIndexPath:indexPath]) {
        ShoppingCartItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
        [self deleteGoodsWithGoodsCartIDs:itemVM.goods_cart_id];
    }
}

- (NSString *)cartIDAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCartItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    return itemVM.goods_cart_id;
}

#pragma mark -删除商品
- (void)deleteGoodsWithGoodsCartIDs:(NSString *)goodsCartIDs
{
    self.loading = YES;
    @weakify(self);
    RACDisposable *disPos = [[[ShoppingCartService sharedInstance] deleteCartGoodsWithGoods_cart_ids:goodsCartIDs] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedPullToRefresh;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        self.currentSignalType = ShoppingCartViewModel_Signal_Type_TipLoading;
        [self.updatedContentSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -编辑状态
// 反置编辑状态
- (void)revalEditing
{
    if (self.empty) {
        return;
    }
    self.editting = !self.editting;
    
    [self mapEdittingState];
    
    self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedReloadView;
    [self.updatedContentSignal sendNext:nil];
}
// 映射编辑状态
- (void)mapEdittingState
{
    @weakify(self);
    [[self productArray] enumerateObjectsUsingBlock:^(ShoppingCartItemViewModel *item, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        item.editting = self.editting;
        if (!self.editting) {
            item.editSelected = NO;
        }
    }];
}

#pragma mark -底部栏相关
// 选中商品个数
- (NSInteger)selectedGoodsNumber
{
    return [[self productArray] linq_count:^BOOL(ShoppingCartItemViewModel *item) {
        return item.editting==NO && item.paySelected==YES;
    }];
}
// 总价格
- (NSString *)totalPrice
{
    NSArray *selecteds = [[self productArray] linq_where:^BOOL(ShoppingCartItemViewModel *item) {
        return item.editting==NO && item.paySelected==YES;
    }];
    __block CGFloat totalPrice = 0.0;
    [selecteds enumerateObjectsUsingBlock:^(ShoppingCartItemViewModel *item, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice += ([item.productPrice floatValue]*item.productQuantity);
    }];
    return [NSString stringWithFormat:@"%.2f",totalPrice];
}
// 是否全选
- (BOOL)checkAllSelected
{
    @weakify(self);
    BOOL isAll = [[self productArray] linq_all:^BOOL(ShoppingCartItemViewModel *item) {
        @strongify(self);
        if (self.editting) {
            return item.editSelected == YES;
        }else{
            return item.paySelected == YES;
        }
    }];
    return isAll;
}
// 反置全选状态
- (void)revalAllCheck
{
    BOOL toBeIsAll = ![self checkAllSelected];
    @weakify(self);
    [[self productArray] enumerateObjectsUsingBlock:^(ShoppingCartItemViewModel *item, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if (self.editting) {
            item.editSelected = toBeIsAll;
        }else{
            item.paySelected = toBeIsAll;
        }
    }];
    
    self.currentSignalType = ShoppingCartViewModel_Signal_Type_NeedReloadView;
    [self.updatedContentSignal sendNext:nil];
}
// 结算
- (void)gotoPay
{
    // 校验是否选中不可售商品
    BOOL selectAnyInvalid = [[self productArray] linq_any:^BOOL(ShoppingCartItemViewModel *item) {
        return item.editting==NO && item.paySelected==YES &&(item.underCart||item.outStock);
    }];
    if (selectAnyInvalid) {
        LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                        message:@"你所选择的商品含有不符合购买的商品,请重新结算"
                                                         titles:@[@"我知道了"]
                                                          click:nil];
        [alert show];
        return;
    }
    
    NSString *selectedCartIDs = [[[[self productArray] linq_where:^BOOL(ShoppingCartItemViewModel *item1) {
        return item1.editting==NO && item1.paySelected==YES;
    }] linq_select:^id(ShoppingCartItemViewModel *item2) {
        return @([item2.goods_cart_id integerValue]);
    }] JSONString];

    // 购物车内都为储值商品
    ConfirmOrderViewModel *confirmVM =
    [[ConfirmOrderViewModel alloc] initWithConfirm_order_from:ConfirmOrderFrom_ShoppingCart
                                                   goods_type:GoodsDetailType_Normal
                                                goods_cart_id:selectedCartIDs
                                                     goods_id:nil
                                                 goods_sku_id:nil
                                                     quantity:nil
                                            activity_flash_id:nil
                                            activity_group_id:nil
                                          activity_bargain_id:nil
                                              bargain_open_id:nil
                                                storehouse_id:nil];
    self.currentSignalType = ShoppingCartViewModel_Signal_Type_GotoConfirmOrder;
    [self.updatedContentSignal sendNext:confirmVM];
}
// 删除选中商品
- (void)deleteSelectGoods
{
    BOOL anySelected = [[self productArray] linq_any:^BOOL(ShoppingCartItemViewModel *item) {
        return item.editting==YES && item.editSelected==YES;
    }];
    if (!anySelected) {
        [DLLoading DLToolTipInWindow:@"未选中任何商品"];
        return;
    }
    
    NSString *selectedCartIDs = [[[[self productArray] linq_where:^BOOL(ShoppingCartItemViewModel *item1) {
        return item1.editting==YES && item1.editSelected==YES;
    }] linq_select:^id(ShoppingCartItemViewModel *item2) {
        return item2.goods_cart_id;
    }] componentsJoinedByString:@"|"];
    
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"选中商品将从购物车删除"
                                                     titles:@[@"取消",@"确定"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              [self deleteGoodsWithGoodsCartIDs:selectedCartIDs];
                                                          }
                                                      }];
    [alert show];
}

#pragma mark -cell类型相关
// 某行cell是否商品
- (BOOL)isProductCellAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    return [itemVM isKindOfClass:[ShoppingCartItemViewModel class]];
}
// 商品数组
- (NSArray *)productArray
{
    return [[self.dataArray linq_selectMany:^id(LYItemUIBaseViewModel *sectionVM) {
        return sectionVM.childViewModels;
    }] linq_where:^BOOL(LYItemUIBaseViewModel *itemVM) {
        return [itemVM isKindOfClass:[ShoppingCartItemViewModel class]];
    }];
}

#pragma mark -跳转
// 商品详情
- (void)gotoGoodsDetailWithVM:(id)vm
{
    self.currentSignalType = ShoppingCartViewModel_Signal_Type_GotoGoodsDetail;
    [self.updatedContentSignal sendNext:vm];
}
// 跳转首页
- (void)gotoHomePage
{
    self.currentSignalType = ShoppingCartViewModel_Signal_Type_GotoHomePage;
    [self.updatedContentSignal sendNext:nil];
}

@end
