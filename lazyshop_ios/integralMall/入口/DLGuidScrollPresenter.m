//
//  DLGuidScrollPresenter.m
//  MobileClassPhone
//
//  Created by Bryce on 15/1/23.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import "DLGuidScrollPresenter.h"

#define SC_WIDTH [UIScreen mainScreen].bounds.size.width

@interface DLGuidScrollPresenter ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy)guidViewCloseBlock closeBlock;

@end

@implementation DLGuidScrollPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 背景
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 设置数据源
// 设置数据源
- (void)setupViewsWithArray:(NSArray *)array
{
    [self setupScrollPresenter];
    self.pageArray = [NSMutableArray arrayWithArray:array];
    [self setupViews];
    [self setRemoveAction];
//    [self setupPageControl];
}
// 设置自身属性
- (void)setupScrollPresenter
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
}
// 子视图
- (void)setupViews
{
    @weakify(self);
    // 载体
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
        make.height.equalTo(self); // 关键，缺少按钮不可用
    }];
    // 子视图布局
    UIView *leftView;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    for (DLGuidPage *page in self.pageArray) {
        [contentView addSubview:page];
        [page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(width);
            make.bottom.top.equalTo(0);
            if (!leftView) {
                make.left.equalTo(contentView.left).offset(0);
            } else {
                make.left.equalTo(leftView.right).offset(0);
            }
        }];
        
        leftView = page;
    }
    // 第一个子视图的左和最后一个子视图的右要和contentView紧贴布局
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView.right);
    }];
    
}
// 最后一页添加隐藏事件
- (void)setRemoveAction
{
    @weakify(self);
    // 最后一页添加消失手势
    UIView *lastpage = self.pageArray.lastObject;
    lastpage.userInteractionEnabled = YES;
    UIButton *hideBtn = [UIButton new];
    [lastpage addSubview:hideBtn];
    CGFloat bottomOffSet = -20;
    [hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(120);
        make.centerX.mas_equalTo(lastpage);
        make.bottom.mas_equalTo(bottomOffSet);
    }];
    // 点击消失
    hideBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self removeGuidView];
        return [RACSignal empty];
    }];
}
// 页码器
- (void)setupPageControl
{
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.pageArray.count;
    _pageControl.currentPage = 0;
    [self.superview addSubview:_pageControl];
    @weakify(self);
    CGFloat bottomOffset = -16;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.superview);
        make.bottom.equalTo(self.superview.bottom).offset(bottomOffset);
        make.height.equalTo(10);
        make.width.equalTo(self);
    }];
}
#pragma mark -移除引导页
- (void)removeGuidView
{
    @weakify(self);
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeFromSuperview];
        if (self.closeBlock) {
            self.closeBlock();
        }
    }];
}
// 设置引导页关闭的回调
- (void)guidViewClose:(guidViewCloseBlock)block
{
    self.closeBlock=block;
}

#pragma mark -界面变化
// 透明度
- (void)setAlpha:(CGFloat)alpha
{
    [super setAlpha:alpha];
}
// 移除视图
- (void)removeFromSuperview
{
    [self.pageControl removeFromSuperview];
    [super removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    if (scrollView.contentOffset.x > SC_WIDTH*(self.pageArray.count-1)) {
        [self removeGuidView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/SC_WIDTH == self.pageArray.count-1) {
        self.bounces = YES;
    }else{
        self.bounces = NO;
    }
}
@end
