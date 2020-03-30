//
//  HomeSecKillCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeSecKillCell.h"

#import "HomeSecKillHeaderView.h"
#import "HomeSecKillCellViewModel.h"

@interface HomeSecKillCell()

@property (nonatomic,strong)HomeSecKillHeaderView *headerView;

@end

@implementation HomeSecKillCell

- (instancetype)init
{
    if (self = [super init]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 头视图
    HomeSecKillHeaderView *header = [HomeSecKillHeaderView new];
    self.headerView = header;
    [self addSubview:self.headerView];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mainCollectionView.top);
    }];
    @weakify(self);
    [header.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
    }];
}

- (void)bindViewModel:(HomeSecKillCellViewModel *)viewModel
{
    [super bindViewModel:viewModel];
    [self.headerView resetTitle:viewModel.slogan];
}

@end
