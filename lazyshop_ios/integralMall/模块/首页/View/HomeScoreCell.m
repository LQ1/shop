//
//  HomeScoreCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeScoreCell.h"

#import "HomeCellTextHeaderView.h"
#import "HomeHoriScrollBaseView.h"
#import "HomeScoreScrollItemCell.h"
#import "HomeSingleImageView.h"
#import "HomeScoreCellViewModel.h"

#define HomeScoreCellScrollHeight 95.0f
#define HomeScoreCellScrollBottomGap 12.0f
#define HomeScoreCellScrollHWScale 162./345.

@interface HomeScoreCell ()

@property (nonatomic, strong) HomeHoriScrollBaseView *scrollView;
@property (nonatomic, strong) HomeSingleImageView *singleImgView;

@end

@implementation HomeScoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // header
    HomeCellTextHeaderView *header = [[HomeCellTextHeaderView alloc] initWithTitle:@"积 分 商 城"];
    [self.contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(HomeCellTextHeaderViewListHeight);
    }];
    // scroll
    HomeHoriScrollBaseView *scrollView = [[HomeHoriScrollBaseView alloc] initWithItemWidth:210
                                                                                itemHeight:HomeScoreCellScrollHeight
                                                                                   itemGap:25
                                                                              leftRightGap:15
                                                                             itemCellClass:[HomeScoreScrollItemCell class]];
    self.scrollView = scrollView;
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(header.bottom);
        make.height.mas_equalTo(scrollView.viewHeight);
    }];
    @weakify(self);
    [scrollView.itemClickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.itemClickSignal sendNext:x];
    }];
    // singleView
    self.singleImgView = [[HomeSingleImageView alloc] initWithHWScale:HomeScoreCellScrollHWScale
                                                         leftRightGap:15];
    [self.contentView addSubview:self.singleImgView];
    [self.singleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(scrollView.bottom).offset(HomeScoreCellScrollBottomGap);
    }];
    [self.singleImgView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.baseClickSignal sendNext:nil];
    }];
}

#pragma mark -height
+ (CGFloat)fetchCellHeight
{
    return HomeCellTextHeaderViewListHeight+HomeScoreCellScrollHeight+HomeScoreCellScrollBottomGap+[HomeSingleImageView fetchHeightWithHWScale:HomeScoreCellScrollHWScale leftRightGap:15];
}

#pragma mark -bind
- (void)bindViewModel:(HomeScoreCellViewModel *)vm
{
    [self.scrollView bindViewModel:vm];
    [self.singleImgView reloadWithImageUrl:vm.scoreSingleImgUrl];
}

@end
