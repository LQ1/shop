//
//  SecKillListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListView.h"

#import "SecKillListViewModel.h"
#import "SecKillListChangeItemCell.h"

#import "SecKillListPageViewController.h"

static NSString *headerCellReuseID = @"SecKillListChangeItemCell";

@interface SecKillListView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)SecKillListViewModel *viewModel;

@property (nonatomic,strong)UICollectionViewFlowLayout *headerLayout;
@property (nonatomic,strong)UICollectionView *headerChangeView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)NSMutableArray *subPageViews;

@end

@implementation SecKillListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subPageViews = [NSMutableArray array];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 头视图
    UICollectionViewFlowLayout *headerLayout = [[UICollectionViewFlowLayout alloc] init];
    self.headerLayout = headerLayout;
    headerLayout.minimumInteritemSpacing = 0;
    headerLayout.minimumLineSpacing = 0;
    headerLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:headerLayout];
    self.headerChangeView = collectionView;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SecKillListChangeItemCellHeight);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [CommUtls colorWithHexString:@"#2f363b"];
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[SecKillListChangeItemCell class] forCellWithReuseIdentifier:headerCellReuseID];
    // 主视图
    self.mainScrollView = [UIScrollView new];
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerChangeView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.delegate = self;
}

#pragma mark -reload
// 执行1次
- (void)reloadDataWithViewModel:(SecKillListViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 刷新header
    self.headerLayout.itemSize = CGSizeMake(KScreenWidth/[viewModel numberOfItemsInSection:0], SecKillListChangeItemCellHeight);
    [self.headerChangeView reloadData];
    // 添加pages
    UIView *lastPage = nil;
    for (int i=0; i<[self.viewModel numberOfItemsInSection:0]; i++) {
        UIView *subView = [UIView new];
        [self.mainScrollView addSubview:subView];
        [self.subPageViews addObject:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.bottom.mas_equalTo(self.mainScrollView);
            if (i == 0) {
                make.left.mas_equalTo(0);
            }else{
                make.left.mas_equalTo(lastPage.right);
            }
            if (i == [self.viewModel numberOfItemsInSection:0]-1) {
                make.right.mas_equalTo(0);
            }
        }];
        lastPage = subView;
    }
    // 默认选中页码
    [self addPageViewControllerAtPage:self.viewModel.currentPage];
}
// 执行多次
- (void)reloadViews
{
    [self.headerChangeView reloadData];
    [self addPageViewControllerAtPage:self.viewModel.currentPage];
}
// addPageView
- (void)addPageViewControllerAtPage:(NSInteger)page
{
    NSIndexPath *indextPath = [NSIndexPath indexPathForRow:page inSection:0];
    SecKillListPageViewController *pageVC = [self.viewModel pageViewControllerAtIndexPath:indextPath];
    UIView *subView = [self.subPageViews objectAtIndex:page];
    if (![subView.subviews containsObject:pageVC.view]) {
        // 添加子视图
        [subView addSubview:pageVC.view];
        [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        // 添加childVC
        [self.viewModel addChildViewControllerAtIndexPath:indextPath];
    }
    // 切换contentOffSet
    self.mainScrollView.contentOffset = CGPointMake(KScreenWidth*page, 0);
}

#pragma mark -scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/KScreenWidth;
    [self.viewModel didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
}

#pragma mark -collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecKillListChangeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:headerCellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self.viewModel cellViewModelForItemAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectItemAtIndexPath:indexPath];
}

@end
