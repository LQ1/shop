//
//  MineViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,MineViewCellType)
{
    MineViewCellType_MyOrders = 0,
    MineViewCellType_MyGroupBuy,
    MineViewCellType_MyBargain,
    MineViewCellType_AddressManage,
    MineViewCellType_Setting,
    MineViewCellType_Connect,
    MineViewCellType_BuyTip,
    MineViewCellType_PostTip,
    MineViewCellType_AfterBuyTip,
    MineViewCellType_Partner,
};

typedef NS_ENUM(NSInteger,MineViewModel_Signal_Type)
{
    MineViewModel_Signal_Type_GotoMyOrders = 0,
    MineViewModel_Signal_Type_GotoMyGroupBuy,
    MineViewModel_Signal_Type_GotoMyBargain,
    MineViewModel_Signal_Type_GotoCommentCenter,
    MineViewModel_Signal_Type_GotoAddressManage,
    MineViewModel_Signal_Type_GotoSetting,
    MineViewModel_Signal_Type_GotoConnect,
    MineViewModel_Signal_Type_GotoBuyTip,
    MineViewModel_Signal_Type_GotoPostTip,
    MineViewModel_Signal_Type_GotoAfterBuyTip,
    MineViewModel_Signal_Type_GotoMyScore,
    MineViewModel_Signal_Type_GotoScoreSignIn,
    MineViewModel_Signal_Type_GotoRelateStore,
    MineViewModel_Signal_Type_GotoCashBack,
    MineViewModel_Signal_Type_GotoMyCoupons,
    MineViewModel_Signal_Type_GotoPersonalMessage,
    MineViewModel_Signal_Type_ReloadView
};

@interface MineViewModel : BaseViewModel

@property (nonatomic,readonly)MineViewModel_Signal_Type currentSignalType;

- (void)getBaseUserData;

- (CGFloat)getPartnerHeight;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (MineViewCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)gotoCommentCenter;
- (void)gotoMyOrdersWithStatus:(OrderStatus)status;
- (void)gotoMyScore;
- (void)gotoScoreSignIn;
- (void)gotoRelateStore;
- (void)gotoCashBack;
- (void)gotoMyCoupons;
- (void)headerClick;

@end
