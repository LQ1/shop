//
//  ProductGridListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductGridListView.h"

#import "ProductListLayout.h"
#import "ProductListItemCell.h"
#import "ProductListViewModel.h"

#import "LYRefreshHeader.h"
#import "LYRefreshFooter.h"

static NSString *cellReuseID = @"ProductListItemCell";

@interface ProductGridListView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)ProductListViewModel *viewModel;

@end

@implementation ProductGridListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 布局
    ProductListLayout *layout = [[ProductListLayout alloc] init];
    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.alwaysBounceVertical = YES;
    [collectionView registerClass:[ProductListItemCell class] forCellWithReuseIdentifier:cellReuseID];
    
    @weakify(self);
    // 下拉刷新
    LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData:YES];
    }];
    self.mainCollectionView.mj_header = header;

    // 上拉刷新
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getData:NO];
    }];
    self.mainCollectionView.mj_footer = footer;
}

- (void)getData:(BOOL)refresh
{
    if (refresh) {
        [self.viewModel getData];
    }else{
        [self.viewModel getMoreData];
    }
}

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainCollectionView reloadData];
    [self.mainCollectionView.mj_header endRefreshing];
    if (viewModel.dataArray.count % PageGetDataNumber || viewModel.dataArray.count == self.viewModel.oldDataCount) {
        [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mainCollectionView.mj_footer endRefreshing];
    }
    self.viewModel.oldDataCount = viewModel.dataArray.count;
}

#pragma mark -collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self.viewModel cellVMForItemAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectItemAtIndexPath:indexPath];
}

@end
