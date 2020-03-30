//
//  MyOrdersSectionFooter.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUISectionBaseView.h"

#define MyOrdersSectionFooterHeight 85.0f

typedef NS_ENUM(NSInteger,MyOrdersSectionFooter_ClickType)
{
    MyOrdersSectionFooter_ClickType_DeleteOrder = 0,
    MyOrdersSectionFooter_ClickType_ConfirmOrder,
    MyOrdersSectionFooter_ClickType_CancelOrder,
    MyOrdersSectionFooter_ClickType_PayOrder
};

@interface MyOrdersSectionFooter : LYItemUISectionBaseView

@property (nonatomic,readonly) RACSubject *clickSignal;

@end
