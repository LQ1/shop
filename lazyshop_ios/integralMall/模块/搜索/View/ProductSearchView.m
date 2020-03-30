//
//  ProductSearchView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchView.h"

#import "ProductSearchHistoryClearView.h"
#import "ProductSearchViewModel.h"
#import "ProductSearchHistoryItemCell.h"

static NSString *cellReuseID = @"ProductSearchHistoryItemCell";

@interface ProductSearchView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTable;
@property (nonatomic,strong) ProductSearchViewModel *viewModel;

@end

@implementation ProductSearchView

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
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];

    // 头视图
    UIView *gapView = [UIView new];
    gapView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self addSubview:gapView];
    [gapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(7.5);
    }];
    
    // 标题
    UIView *tipView = [UIView new];
    [self addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(gapView.bottom);
        make.height.mas_equalTo(33);
    }];
    [tipView addBottomLine];
    
    UILabel *tipLabel = [tipView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#333333"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"历史搜索"];
    tipLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    tipLabel.backgroundColor = [UIColor whiteColor];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(tipView);
    }];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(tipView.bottom);
    }];
    
    [mainTable registerClass:[ProductSearchHistoryItemCell class] forCellReuseIdentifier:cellReuseID];
    
    // 尾视图
    ProductSearchHistoryClearView *clearView = [[ProductSearchHistoryClearView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, ProductSearchHistoryClearViewHeight)];
    self.mainTable.tableFooterView = clearView;
    @weakify(self);
    [clearView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self clearSearchHistory];
    }];
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(ProductSearchViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductSearchHistoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

#pragma mark -清空搜索历史
- (void)clearSearchHistory
{
    [self.viewModel clearSearchHistory];
}

@end
