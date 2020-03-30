//
//  CategoryRightRowCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryRightRowCell.h"

#import "CategoryRightItemCell.h"
#import "CategoryViewMacro.h"
#import "CategoryRightItemCell.h"
#import "CategorySecondItemViewModel.h"

static NSString *itemCellReuseID = @"CategoryRightItemCell";

@interface CategoryRightRowCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)CategorySecondItemViewModel *viewModel;

@end

@implementation CategoryRightRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gotoProductListSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoProductListSignal", self.class];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 背景
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#F5F5F5"];
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = CategoryRightItemVerGap;
    layout.itemSize = CGSizeMake(CategoryRightItemWidth, CategoryRightItemHeight);
    layout.sectionInset = UIEdgeInsetsMake(CategoryRightSectionTopGap, CategoryRightItemHoriGap, CategoryRightSectionTopGap, CategoryRightItemHoriGap);
    
    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectionView = collectionView;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(CategoryRightWhiteLeftGap);
        make.right.mas_equalTo(-CategoryRightWhiteRightGap);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.layer.cornerRadius = 5;
    collectionView.layer.masksToBounds = YES;
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[CategoryRightItemCell class] forCellWithReuseIdentifier:itemCellReuseID];
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(CategorySecondItemViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainCollectionView reloadData];
}

#pragma mark -collectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryRightItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCellReuseID forIndexPath:indexPath];
    [cell reloadDataWithViewModel:[self.viewModel viewModelForItemAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.gotoProductListSignal sendNext:[self.viewModel didSelectItemAtIndexPath:indexPath]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
