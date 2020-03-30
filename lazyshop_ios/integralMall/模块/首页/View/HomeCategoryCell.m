//
//  HomeCategoryCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeCategoryCell.h"

#import "HomeCategoryMacro.h"
#import "HomeCategoryItemCell.h"
#import "HomeCategoryCellViewModel.h"

#define ItemCellReuseID @"HomeCategoryItemCell"

@interface HomeCategoryCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)HomeCategoryCellViewModel *viewModel;
@property (nonatomic,strong)UICollectionView *mainCollectionView;

@end

@implementation HomeCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = HomeCategoryLayoutLeftGap;
    layout.minimumLineSpacing = HomeCategoryLayoutLineGap;
    layout.itemSize = CGSizeMake(HomeCategoryItemCellWidth, HomeCategoryItemCellHeight);
    layout.sectionInset = UIEdgeInsetsMake(HomeCategoryLayoutTopGap, HomeCategoryLayoutLeftGap, HomeCategoryLayoutBottomGap, HomeCategoryLayoutLeftGap);

    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[HomeCategoryItemCell class] forCellWithReuseIdentifier:ItemCellReuseID];
}

- (void)bindViewModel:(HomeCategoryCellViewModel *)viewModel
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
    HomeCategoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellReuseID forIndexPath:indexPath];
    [cell reloadDataWithModel:[self.viewModel itemModelAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
