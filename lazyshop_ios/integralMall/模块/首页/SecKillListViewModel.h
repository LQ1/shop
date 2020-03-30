//
//  SecKillListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@class SecKillListPageViewController;

typedef NS_ENUM(NSInteger,SecKillListViewModel_Signal_Type)
{
    SecKillListViewModel_Signal_Type_AddToChildVC = 0,
    SecKillListViewModel_Signal_Type_ReloadView
};

@interface SecKillListViewModel : LYBaseViewModel

@property (nonatomic,readonly)NSInteger currentPage;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (id)cellViewModelForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (SecKillListPageViewController *)pageViewControllerAtIndexPath:(NSIndexPath *)indexPath;
- (void)addChildViewControllerAtIndexPath:(NSIndexPath *)indexPath;

@end
