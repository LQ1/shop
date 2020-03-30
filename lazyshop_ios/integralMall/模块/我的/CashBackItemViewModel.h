//
//  CashBackItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

typedef NS_ENUM(NSInteger,CashBackState)
{
    CashBackState_Invalid = 0,
    CashBackState_NotUse,
    CashBackState_Used
};

@interface CashBackItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign) BOOL isHistoryItem;

// 第几期
@property (nonatomic,copy) NSString *cashBackIssue;
// 返利金额
@property (nonatomic,copy) NSString *cashBackMoney;
// 返利码
@property (nonatomic,copy) NSString *cashBackCode;
// 返利码可用时间
@property (nonatomic,copy) NSString *can_use_at;
// 返利码状态
@property (nonatomic,assign) CashBackState state;
// 是否收起后展示
@property (nonatomic,assign) BOOL is_current;

// 返利历史
@property (nonatomic,copy) NSString *cashBackDate;
@property (nonatomic,copy) NSString *cashBackTime;
@property (nonatomic,copy) NSString *cashBackTip;

- (CGFloat)cellHeight;

@end
