//
//  HomeRecommendCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeRecommendCell.h"

#import "HomeCellTextHeaderView.h"
#import "HomeRecommendItemCell.h"
#import "HomeRecommendCellViewModel.h"

static NSString *cellReuseID = @"HomeRecommendItemCell";

@interface HomeRecommendCell () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) HomeRecommendCellViewModel *viewModel;

@end

@implementation HomeRecommendCell

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
    HomeCellTextHeaderView *header = [[HomeCellTextHeaderView alloc] initWithTitle:@"懒 店 推 荐"];
    [self.contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(HomeRecommendCellHeaderHeight);
    }];
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    mainTable.scrollEnabled = NO;
    [self.contentView addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(header.bottom);
    }];
    [mainTable registerClass:[HomeRecommendItemCell class]
      forCellReuseIdentifier:cellReuseID];
}

#pragma mark -reload
- (void)bindViewModel:(HomeRecommendCellViewModel *)vm
{
    self.viewModel = vm;
    [self.mainTable reloadData];
}

#pragma mark -table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeRecommendItemCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeRecommendItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellForRowAtIndexPath:indexPath]];
    return cell;
}

@end
