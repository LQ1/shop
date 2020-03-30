//
//  FeedBackTypeSwitchView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackTypeSwitchView.h"

#import "FeedBackTypeItemCell.h"
#import "FeedBackTypeItemCellViewModel.h"

static NSString *cellReuseID = @"FeedBackTypeItemCell";

@interface FeedBackTypeSwitchView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *mainView;
@property (nonatomic,strong)NSArray *itemViewModels;
@property (nonatomic,assign)CGFloat height;

@end

@implementation FeedBackTypeSwitchView

- (instancetype)initWithHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        self.height = height;
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 列表
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainView = collectionView;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[FeedBackTypeItemCell class] forCellWithReuseIdentifier:cellReuseID];
}

#pragma mark -数据刷新
- (void)reloadDataWithItemViewModels:(NSArray *)itemViewModels
{
    CGFloat itemWidth = 0.0f;
    itemWidth = (KScreenWidth-12*3-15*2)/itemViewModels.count;
    ((UICollectionViewFlowLayout *)self.mainView.collectionViewLayout).itemSize = CGSizeMake(itemWidth, self.height);
    self.itemViewModels = [NSArray arrayWithArray:itemViewModels];
    [self.mainView reloadData];
    [self judgeSelectedToSend];
}
// 刷新内容
- (void)reload
{
    [self.mainView reloadData];
}

#pragma mark -collectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemViewModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeedBackTypeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self cellViewModelForItemAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block BOOL isChange = NO;
    [self.itemViewModels enumerateObjectsUsingBlock:^(FeedBackTypeItemCellViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            if (!itemVM.selected) {
                itemVM.selected = YES;
                isChange = YES;
            }
        }else{
            itemVM.selected = NO;
        }
    }];
    
    if (isChange) {
        [self.mainView reloadData];
        [self judgeSelectedToSend];
    }
}


#pragma mark -private
- (FeedBackTypeItemCellViewModel *)cellViewModelForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemViewModels objectAtIndex:indexPath.row];
}

- (void)judgeSelectedToSend
{
    FeedBackTypeItemCellViewModel *itemVM = [self.itemViewModels linq_where:^BOOL(FeedBackTypeItemCellViewModel *item) {
        return item.selected == YES;
    }].linq_firstOrNil;
    if (itemVM) {
        [self.clickSignal sendNext:@(itemVM.itemType)];
    }
}

@end
