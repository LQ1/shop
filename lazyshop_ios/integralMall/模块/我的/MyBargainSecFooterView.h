//
//  MyBargainSecFooterView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUISectionBaseView.h"

typedef NS_ENUM(NSInteger,MyBargainSecFooterViewClickType)
{
    MyBargainSecFooterViewClickType_InviteFriends = 0,
    MyBargainSecFooterViewClickType_ImediatelyBuy
};

#define MyBargainSecFooterViewHeight 86.0f

@interface MyBargainSecFooterView : LYItemUISectionBaseView

@property (nonatomic,readonly)RACSubject *clickSignal;

@end
