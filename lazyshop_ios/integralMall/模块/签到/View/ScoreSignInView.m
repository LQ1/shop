//
//  ScoreSignInView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInView.h"

#import "ScoreSignInViewModel.h"
#import "ScoreSignInHeaderView.h"
#import "ScoreSignInCalendarView.h"

@interface ScoreSignInView ()

@property (nonatomic, strong) ScoreSignInHeaderView *headerView;
@property (nonatomic, strong) ScoreSignInCalendarView *calendarView;

@end

@implementation ScoreSignInView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // header
    self.headerView = [ScoreSignInHeaderView new];
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(ScoreSignInHeaderViewHeight);
    }];
    // calendar
    self.calendarView = [[ScoreSignInCalendarView alloc] init];
    [self addSubview:self.calendarView];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.bottom).offset(16);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)reloadDataWithViewModel:(ScoreSignInViewModel *)viewModel
{
    [self.headerView reloadDataWithViewModel:viewModel];
    [self.calendarView reloadDataWithViewModel:viewModel];
}

@end
