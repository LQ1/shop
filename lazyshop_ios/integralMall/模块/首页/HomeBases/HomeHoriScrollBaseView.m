//
//  HomeHoriScrollBaseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeHoriScrollBaseView.h"

#import "HomeHoriScrollItemBaseCell.h"

@interface HomeHoriScrollBaseView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainCollectionView;


@end

@implementation HomeHoriScrollBaseView

- (instancetype)initWithItemWidth:(CGFloat)itemWidth
                       itemHeight:(CGFloat)itemHeight
                          itemGap:(CGFloat)itemGap
                     leftRightGap:(CGFloat)leftRightGap
                    itemCellClass:(Class)itemCellClass
{
    self = [super init];
    if (self) {
        _itemClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ itemClickSignal", self.class];
        // 布局参数
        self.itemWidth = itemWidth;
        self.itemHeight = itemHeight;
        self.itemGap = itemGap;
        self.leftRightGap = leftRightGap;
        self.itemCellClass = itemCellClass;
        self.viewHeight = itemHeight;
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = self.itemGap;
        layout.itemSize = CGSizeMake(self.itemWidth, self.itemHeight);
        layout.sectionInset = UIEdgeInsetsMake(0, self.leftRightGap, 0, self.leftRightGap);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
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
        collectionView.showsHorizontalScrollIndicator = YES;
        
        [collectionView registerClass:itemCellClass
           forCellWithReuseIdentifier:NSStringFromClass(itemCellClass)];
    }
    return self;
}

- (void)bindViewModel:(HomeHoriScrollBaseViewModel *)viewModel
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
    HomeHoriScrollItemBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.itemCellClass) forIndexPath:indexPath];
    [cell reloadDataWithModel:[self.viewModel itemModelAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.itemClickSignal sendNext:[self.viewModel didSelectRowAtIndexPath:indexPath]];
}

@end
