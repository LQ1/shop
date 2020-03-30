//
//  CashBackHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUISectionBaseView.h"

#define CashBackHeaderViewHeight 87.5f

@interface CashBackHeaderView : LYItemUISectionBaseView

@property (nonatomic,readonly) RACSubject *gotoOrderDetailSignal;
@property (nonatomic,readonly) RACSubject *gotoBindShopSignal;

@end
