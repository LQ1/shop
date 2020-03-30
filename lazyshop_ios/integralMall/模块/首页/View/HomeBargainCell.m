//
//  HomeBargainCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeBargainCell.h"

#import "HomeBargainHeaderView.h"
#import "HomeActivityBaseViewModel.h"

@interface HomeBargainCell()

@property (nonatomic,strong)HomeBargainHeaderView *headerView;

@end

@implementation HomeBargainCell

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
    HomeBargainHeaderView *header = [HomeBargainHeaderView new];
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

- (void)bindViewModel:(HomeActivityBaseViewModel *)viewModel
{
    [super bindViewModel:viewModel];
    [self.headerView resetTitle:viewModel.slogan];
}

@end
