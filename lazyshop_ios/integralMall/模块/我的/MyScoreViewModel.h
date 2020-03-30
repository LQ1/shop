//
//  MyScoreViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

#import "MyScoreDetailSegementView.h"

#define MyScoreListPageNum 20

typedef NS_ENUM(NSInteger, MyScoreViewModel_Signal_Type)
{
    MyScoreViewModel_Signal_Type_GotoSignalVC,
    MyScoreViewModel_Signal_Type_FetchScoreListSuccess,
    MyScoreViewModel_Signal_Type_FetchScoreListError
};

@interface MyScoreViewModel : LYBaseViewModel

@property (nonatomic, copy) NSString *vipLevelName;
@property (nonatomic, copy) NSString *levelTip;
@property (nonatomic, copy) NSString *growthTip;

- (void)getData;
- (void)getScoreListWithMore:(BOOL)more;

- (void)gotoSignalVC;

/*
 *  切换数据源显示
 */
- (void)changeDataSourceToClickType:(MyScoreDetailSegementViewClickType)cellType;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
