//
//  HomeGroupBuyCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeGroupBuyCell.h"

#import "HomeGroupByHeaderView.h"
#import "HomeActivityBaseViewModel.h"

@interface HomeGroupBuyCell()

@property (nonatomic,strong)HomeGroupByHeaderView *headerView;

@end

@implementation HomeGroupBuyCell

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
    HomeGroupByHeaderView *header = [HomeGroupByHeaderView new];
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
