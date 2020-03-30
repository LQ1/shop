//
//  MineOrderCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

typedef NS_ENUM(NSInteger,MineOrderCellClickType)
{
    MineOrderCellClickType_LookAll = 0,
    MineOrderCellClickType_WaitToPay,
    MineOrderCellClickType_WaitToSend,
    MineOrderCellClickType_WaitToRecommend,
    MineOrderCellClickType_Refound
};

#define MineOrderCellHeight 117.0f

@interface MineOrderCell : LYItemUIBaseCell

@property (nonatomic,readonly) RACSubject *clickSignal;

- (void)reload;

@end
