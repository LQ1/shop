//
//  LYHeaderSwitchView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYHeaderSwitchView.h"

#import "LYHeaderSwitchItemCell.h"
#import "LYHeaderSwitchItemViewModel.h"

static NSString *cellReuseID = @"LYHeaderSwitchItemCell";

@interface LYHeaderSwitchView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *mainView;
@property (nonatomic,strong)NSArray *itemViewModels;
@property (nonatomic,assign)CGFloat height;

@end

@implementation LYHeaderSwitchView

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
    layout.minimumLineSpacing = 0;
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
    
    [collectionView registerClass:[LYHeaderSwitchItemCell class] forCellWithReuseIdentifier:cellReuseID];
}

#pragma mark -数据刷新
- (void)reloadDataWithItemViewModels:(NSArray *)itemViewModels
{
    CGFloat itemWidth = 0.0f;
    if (self.divideStyle) {
        itemWidth = KScreenWidth/itemViewModels.count;
    }else{
        itemWidth = 70;
    }
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
    LYHeaderSwitchItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell bindViewModel:[self cellViewModelForItemAtIndexPath:indexPath]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block BOOL isChange = NO;
    [self.itemViewModels enumerateObjectsUsingBlock:^(LYHeaderSwitchItemViewModel *itemVM, NSUInteger idx, BOOL * _Nonnull stop) {
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
- (LYHeaderSwitchItemViewModel *)cellViewModelForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.itemViewModels objectAtIndex:indexPath.row];
}

- (void)judgeSelectedToSend
{
    LYHeaderSwitchItemViewModel *itemVM = [self.itemViewModels linq_where:^BOOL(LYHeaderSwitchItemViewModel *item) {
        return item.selected == YES;
    }].linq_firstOrNil;
    if (itemVM) {
        [self.clickSignal sendNext:@(itemVM.itemType)];
    }
}

@end
