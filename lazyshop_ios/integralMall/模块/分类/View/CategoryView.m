//
//  CategoryView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryView.h"

#import "CategroyViewModel.h"
#import "CategoryLeftTableCell.h"
#import "CategoryViewMacro.h"
#import "CategoryRightPageView.h"

static NSString *leftTableCellReuseID = @"CategoryLeftTableCell";

@interface CategoryView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CategroyViewModel *viewModel;

@property (nonatomic,strong)UITableView *leftTableView;
@property (nonatomic,strong)UIView *rightContentView;
@property (nonatomic,strong)NSMutableArray *rightPageViews;

@end

@implementation CategoryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightPageViews = [NSMutableArray array];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#F5F5F5"];
    // 左侧table
    UITableView *leftTable = [UITableView new];
    self.leftTableView = leftTable;
    leftTable.dataSource = self;
    leftTable.delegate = self;
    leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTable.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftTable];
    [leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CategoryLeftBarWidth);
    }];
    
    [leftTable registerClass:[CategoryLeftTableCell class] forCellReuseIdentifier:leftTableCellReuseID];
    
    // 右侧scrollView
    UIView *rightContentView = [UIView new];
    rightContentView.backgroundColor = [UIColor clearColor];
    self.rightContentView = rightContentView;
    [self addSubview:rightContentView];
    [rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTableView.right);
        make.top.bottom.right.mas_equalTo(0);
    }];
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(CategroyViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.leftTableView reloadData];
    for (CategoryRightPageView *pageView in self.rightPageViews) {
        [pageView removeFromSuperview];
    }
    [self.rightPageViews removeAllObjects];
    // 默认选中
    [self selectRowAtIndexPath:[self.viewModel fetchDefaultSelectedIndexPath]];
}

#pragma mark -tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CategoryLeftBarItemHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryLeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:leftTableCellReuseID];
    [cell reloadDataWithViewModel:[self.viewModel cellVMForRowAtIndexPath:indexPath]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectRowAtIndexPath:indexPath];
}

#pragma mark -切换
// 选中某行
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
    [self changeToPageViewAtIndexPath:indexPath];
}
// 切换pageView
- (void)changeToPageViewAtIndexPath:(NSIndexPath *)indexPath
{
    // 没有才添加
    if (![self existPageViewAtIndexPath:indexPath]) {
        CategoryRightPageView *pageView = [CategoryRightPageView new];
        pageView.pageNumber = indexPath.row;
        [pageView reloadDataWithViewModel:[self.viewModel cellVMForRowAtIndexPath:indexPath]];
        [self.rightContentView addSubview:pageView];
        [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.rightContentView);
        }];
        // 跳转商品列表
        @weakify(self);
        [pageView.gotoProductListSignal subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel gotoProductListWithVM:x];
        }];
        [self.rightPageViews addObject:pageView];
    }
    // 隐藏其他
    [self.rightPageViews enumerateObjectsUsingBlock:^(CategoryRightPageView *pageView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == pageView.pageNumber) {
            pageView.hidden = NO;
        }else{
            pageView.hidden = YES;
        }
    }];
}
// pageView是否已添加
- (BOOL)existPageViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.rightPageViews linq_any:^BOOL(CategoryRightPageView *pageView) {
        return pageView.pageNumber == indexPath.row;
    }];
}


@end
