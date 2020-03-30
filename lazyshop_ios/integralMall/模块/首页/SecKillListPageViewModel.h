//
//  SecKillListChangeItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class SecKillTimePointModel;

// 秒杀活动状态
typedef NS_ENUM(NSInteger,SecKillListState)
{
    SecKillListState_WillBegin = 0,
    SecKillListState_Begining,
    SecKillListState_IsEnd
};

// 信号类型
typedef NS_ENUM(NSInteger,SecKillListPageViewModel_Signal_Type)
{
    SecKillListPageViewModel_Signal_Type_FetchListSuccess = 0,
    SecKillListPageViewModel_Signal_Type_FetchListFailed,
    SecKillListPageViewModel_Signal_Type_TipLoading,
    SecKillListPageViewModel_Signal_Type_GotoGoodsDetail
};

@interface SecKillListPageViewModel : LYItemUIBaseViewModel

@property (nonatomic,readonly)SecKillListPageViewModel_Signal_Type currentSignalType;

// 基础属性
@property (nonatomic,assign)SecKillListState state;
@property (nonatomic,copy  )NSString *startTime;
@property (nonatomic,assign)NSInteger validSeconds;
@property (nonatomic,assign)BOOL selected;

@property (nonatomic,assign)BOOL hasAddToChildVC;

- (instancetype)initWithModel:(SecKillTimePointModel *)pointModel
                     allTimes:(NSArray *)allTimes
                  currentTime:(NSString *)currentTime;

- (NSString *)stringValidTime;

// 获取数据
- (void)getDataRefresh:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)gotoGoodsDetailAtIndexPath:(NSIndexPath *)indexPath;

@end
