//
//  HomeActivityBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeActivityBaseCell.h"

#import "HomeActivityItemCell.h"
#import "HomeActivityBaseHeaderView.h"
#import "HomeActivityBaseViewModel.h"

#define ItemCellReuseID @"HomeActivityItemCell"

@interface HomeActivityBaseCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)HomeActivityBaseViewModel *viewModel;
@property (nonatomic,strong)UICollectionView *mainCollectionView;

@end

@implementation HomeActivityBaseCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        _baseClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ baseClickSignal", self.class];
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(HomeActivityCellWidth, HomeActivityCellHeight);
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 列表
        UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.mainCollectionView = collectionView;
        [self addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(HomeActivityBaseHeaderViewHeight);
        }];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        
        [collectionView registerClass:[HomeActivityItemCell class] forCellWithReuseIdentifier:ItemCellReuseID];
    }
    return self;
}

- (void)bindViewModel:(HomeActivityBaseViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainCollectionView reloadData];
}

#pragma mark -collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel itemCountAtSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeActivityItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellReuseID forIndexPath:indexPath];
    [cell reloadDataWithModel:[self.viewModel itemModelAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.baseClickSignal sendNext:[self.viewModel didSelectRowAtIndexPath:indexPath]];
}

#pragma mark -cell高度
+ (CGFloat)fetchCellHeight
{
    return HomeActivityCellHeight+HomeActivityBaseHeaderViewHeight;
}

@end
