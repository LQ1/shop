//
//  HomeChosenCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeChosenCell.h"

#import "HomeCellTextHeaderView.h"
#import "ProductListItemCell.h"
#import "ProductListLayout.h"
#import "HomeChosenCellViewModel.h"
#import "HomeChosenMacro.h"

#define ItemCellReuseID @"ProductListItemCell"

@interface HomeChosenCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)HomeChosenCellViewModel *viewModel;
@property (nonatomic,strong)HomeCellTextHeaderView *headerView;
@property (nonatomic,strong)UICollectionView *mainCollectionView;

@end

@implementation HomeChosenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 背景
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#EAEAEA"];
    // 头视图
    HomeCellTextHeaderView *header = [[HomeCellTextHeaderView alloc] initWithTitle:@"懒 店 精 选"];
    self.headerView = header;
    [self.contentView addSubview:self.headerView];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HomeChosenHeaderViewTopGap);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HomeChosenHeaderViewHeight);
    }];
    
    // 布局
    ProductListLayout *layout = [[ProductListLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.bottom);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[ProductListItemCell class] forCellWithReuseIdentifier:ItemCellReuseID];
}

- (void)bindViewModel:(HomeChosenCellViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainCollectionView reloadData];
    if (viewModel.usedForRecommend) {
        self.headerView.titleTipLabel.text = @"为 你 推 荐";
    }
}

#pragma mark -collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel itemCountAtSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self.viewModel itemModelAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.baseClickSignal sendNext:[self.viewModel didSelectRowAtIndexPath:indexPath]];;
}

@end
