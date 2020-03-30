//
//  HomeAllActivityCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeAllActivityCell.h"

#import "HomeActivityBaseCell.h"
#import "HomeAllActivityHeaderView.h"
#import "HomeAllActivityDetailView.h"

#import "HomeAllActivityCellViewModel.h"

#define HomeAllActivityCellHeaderDetailGap 3.0f
#define HomeAllActivityCellDetaiBottomGap 3.0f


@interface HomeAllActivityCell ()

@property (nonatomic, strong) HomeAllActivityCellViewModel *viewModel;
@property (nonatomic, strong) HomeAllActivityDetailView *detailView;

@end

@implementation HomeAllActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _reloadHomeListSignal = [[RACSubject subject] setNameWithFormat:@"%@ reloadHomeListSignal", self.class];
        _gotoMoreListSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoMoreListSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // header
    HomeAllActivityHeaderView *header = [HomeAllActivityHeaderView new];
    [self.contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(HomeAllActivityHeaderViewHeight);
    }];
    @weakify(self);
    [header setChangeClickBlock:^(HomeAllActivityHeaderViewClickType clickType) {
        @strongify(self);
        [self.viewModel changeToClickType:clickType];
        [self.reloadHomeListSignal sendNext:nil];
    }];
    // detail
    HomeAllActivityDetailView *detailView = [HomeAllActivityDetailView new];
    self.detailView = detailView;
    [self.contentView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(header.bottom).offset(HomeAllActivityCellHeaderDetailGap);
        make.bottom.mas_equalTo(-HomeAllActivityCellDetaiBottomGap);
    }];
    
    [detailView.gotoActivityListSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.gotoMoreListSignal sendNext:x];
    }];
    [detailView.gotoGoodsDetailSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.baseClickSignal sendNext:x];
    }];
}

#pragma mark -Bind
- (void)bindViewModel:(id)vm
{
    self.viewModel = vm;
    [self.detailView reloadDataWithViewModel:vm];
}

#pragma mark -height
+ (CGFloat)fetchCellHeight
{
    return HomeAllActivityHeaderViewHeight+[HomeActivityBaseCell fetchCellHeight]+HomeAllActivityCellHeaderDetailGap+HomeAllActivityCellDetaiBottomGap;
}

@end
