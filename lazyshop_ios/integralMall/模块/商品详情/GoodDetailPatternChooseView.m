//
//  GoodDetailPatternChooseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseView.h"

#import "UICollectionViewLeftAlignedLayout.h"

#import "GoodDetailPatternChooseItemCell.h"
#import "GoodsDetailPramsDetailViewModel.h"
#import "LYItemUIBaseViewModel.h"
#import "GoodsDetailViewModel.h"

#import "GoodDetailPatternChooseHeaderView.h"
#import "GoodDetailPatternChooseFooterView.h"
#import "GoodDetailPatternChooseSectionView.h"
#import "GoodDetailPatternChooseSecFooterView.h"

static NSString *cellReuseID = @"GoodDetailPatternChooseItemCell";
static NSString *sectionReuseID = @"GoodDetailPatternChooseSectionView";
static NSString *sectionFooterReuseID = @"GoodDetailPatternChooseSecFooterView";
static NSString *sectionEmptyFooterReuseID = @"GoodDetailPatternChooseSecEmptyFooterView";

@interface GoodDetailPatternChooseView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)GoodDetailPatternChooseHeaderView *headerView;
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)GoodDetailPatternChooseFooterView *footerView;
@property (nonatomic,strong)GoodsDetailPramsDetailViewModel *viewModel;
@property (nonatomic,strong)GoodsDetailViewModel *goodsDetailVM;

@end

@implementation GoodDetailPatternChooseView

- (instancetype)initWithGoodsDetailViewModel:(GoodsDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.goodsDetailVM = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 头视图
    self.headerView = [GoodDetailPatternChooseHeaderView new];
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(GoodDetailPatternChooseHeaderViewHeight);
    }];
    
    // 尾视图
    self.footerView = [[GoodDetailPatternChooseFooterView alloc] initWithGoodsDetailViewModel:self.goodsDetailVM];
    [self addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(GoodDetailPatternChooseFooterViewHeight);
        make.bottom.mas_equalTo(-HOME_BAR_HEIGHT);
    }];
    
    // 布局
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.bottom);
        make.bottom.mas_equalTo(self.footerView.top);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    
    [collectionView registerClass:[GoodDetailPatternChooseItemCell class] forCellWithReuseIdentifier:cellReuseID];
    [collectionView registerClass:[GoodDetailPatternChooseSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionReuseID];
    [collectionView registerClass:[GoodDetailPatternChooseSecFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionFooterReuseID];
    [collectionView registerClass:[LYItemUICollecSectionBaseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionEmptyFooterReuseID];
}

- (void)reloadDataWithViewModel:(GoodsDetailPramsDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainCollectionView reloadData];
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.footerView reloadDataWithViewModel:viewModel];
}

#pragma mark -collectionView代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel numberOfSections];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // 头视图
        GoodDetailPatternChooseSectionView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionReuseID forIndexPath:indexPath];
        [reusableView setTitle:[self.viewModel sectionTitleAtIndexPath:indexPath]];
        return reusableView;
    }else if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == [self.viewModel numberOfSections]-1) {
            // 尾视图
            GoodDetailPatternChooseSecFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionFooterReuseID forIndexPath:indexPath];
            [reusableView bindViewModel:self.viewModel];
            return reusableView;
        }else{
            // 占位尾视图 防止崩溃
            LYItemUICollecSectionBaseView *emptyFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionEmptyFooterReuseID forIndexPath:indexPath];
            return emptyFooter;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KScreenWidth,GoodDetailPatternChooseSectionViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == [self.viewModel numberOfSections]-1) {
        // 最后一组显示 数量选择器 尾视图
        return CGSizeMake(KScreenWidth,GoodDetailPatternChooseSecFooterViewHeight);
    }
    return CGSizeMake(KScreenWidth,0.0001);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailPatternChooseItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self.viewModel itemViewModelAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectItemAtIndexPath:indexPath];
    [self.mainCollectionView reloadData];
    [self.headerView reloadDataWithViewModel:self.viewModel];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel sizeForItemAtIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12.5f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return [self.viewModel minimumInteritemSpacingForSectionAtIndex:section];
}


@end
