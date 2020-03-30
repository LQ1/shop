//
//  GoodsDetailPostageCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPostageCell.h"

#import "GoodsDetailTagCell.h"
#import "GoodsDetailPostageViewModel.h"

static NSString *cellReuseID = @"GoodsDetailTagCell";

@interface GoodsDetailPostageCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UILabel *leftTitleLabel;
@property (nonatomic,strong)UILabel *postageLabel;

@property (nonatomic,strong)GoodsDetailPostageViewModel *viewModel;
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation GoodsDetailPostageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    UIView *topContentView = [UIView new];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topContentView];
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(GoodsDetailPostageCellBaseHeight);
    }];
    // 运费
    self.leftTitleLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:NSTextAlignmentCenter
                                                     textColor:@"#999999"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"运费"];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.centerY.mas_equalTo(topContentView);
    }];
    // 运费金额
    self.postageLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:APP_MainColor
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.postageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.right);
        make.centerY.mas_equalTo(topContentView);
    }];

    UIView *bottomContentView = [UIView new];
    bottomContentView.backgroundColor = [CommUtls colorWithHexString:@"#f6f9f9"];
    [self.contentView addSubview:bottomContentView];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(topContentView.bottom);
    }];
    // 列表
    CGFloat itemWith = (KScreenWidth - 15*2)/GoodsDetailPostageCellRowMax;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(itemWith, GoodsDetailPostageCellBaseHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    [bottomContentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.layer.cornerRadius = 5;
    collectionView.layer.masksToBounds = YES;
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[GoodsDetailTagCell class] forCellWithReuseIdentifier:cellReuseID];
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [bottomContentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark -reload
- (void)bindViewModel:(GoodsDetailPostageViewModel *)vm
{
    self.postageLabel.text = [NSString stringWithFormat:@"¥ %@",vm.postage];
    // 列表
    self.viewModel = vm;
    [self.collectionView reloadData];
}

#pragma mark -delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell reloadTitle:[self.viewModel titleForItemAtIndexPath:indexPath]];
    return cell;
}

@end
