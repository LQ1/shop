//
//  SecKillListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListViewModel.h"

#import "SecKillListPageViewModel.h"

#import "SecKillListPageViewController.h"

#import "SecKillCountDownManager.h"
#import "SecKillTimeModel.h"

#import "SecKillCountDownManager.h"

@interface SecKillListViewModel()

@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic,strong)NSArray *pageViewControllers;

@end

@implementation SecKillListViewModel

#pragma mark -getData
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[[SecKillCountDownManager sharedInstance] fetchSecKillTimes] subscribeNext:^(SecKillTimeModel *model) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [model.time_slice enumerateObjectsUsingBlock:^(SecKillTimePointModel *timePointModel, NSUInteger idx, BOOL * _Nonnull stop) {
            SecKillListPageViewModel *pageVM = [[SecKillListPageViewModel alloc] initWithModel:timePointModel allTimes:model.time_slice currentTime:model.current_at];
            [resultArray addObject:pageVM];
        }];
        // 没有进行中的 默认选中第一个
        BOOL anySelected = [resultArray linq_any:^BOOL(SecKillListPageViewModel *pageVM) {
            return pageVM.selected == YES;
        }];
        if (!anySelected) {
            SecKillListPageViewModel *firstPageVM = resultArray.linq_firstOrNil;
            firstPageVM.selected = YES;
        }
        self.dataArray = [NSArray arrayWithArray:resultArray];
        NSMutableArray *pageVCs = [NSMutableArray array];
        [self.dataArray enumerateObjectsUsingBlock:^(SecKillListPageViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            SecKillListPageViewController *pageVC = [SecKillListPageViewController new];
            pageVC.viewModel = itemVM;
            [pageVCs addObject:pageVC];
            if (itemVM.selected) {
                self.currentPage = idx;
            }
        }];
        self.pageViewControllers = [NSArray arrayWithArray:pageVCs];
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellViewModelForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecKillListPageViewModel *selectVM = [self cellViewModelForItemAtIndexPath:indexPath];
    if (selectVM.selected) {
        return;
    }
    // 重置选中状态
    @weakify(self);
    [self.dataArray enumerateObjectsUsingBlock:^(SecKillListPageViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            @strongify(self);
            itemVM.selected = YES;
            self.currentPage = idx;
        }else{
            itemVM.selected = NO;
        }
    }];
    self.currentSignalType = SecKillListViewModel_Signal_Type_ReloadView;
    [self.updatedContentSignal sendNext:nil];
}

- (SecKillListPageViewController *)pageViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.pageViewControllers objectAtIndex:indexPath.row];
}

- (void)addChildViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    SecKillListPageViewModel *itemVM = [self cellViewModelForItemAtIndexPath:indexPath];
    if (itemVM.selected&&!itemVM.hasAddToChildVC) {
        self.currentSignalType = SecKillListViewModel_Signal_Type_AddToChildVC;
        [self.updatedContentSignal sendNext:[self pageViewControllerAtIndexPath:indexPath]];
        itemVM.hasAddToChildVC = YES;
    }
}

@end
