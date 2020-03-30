//
//  GoodsDetailImageScrollView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailImageScrollView.h"

#import "GoodsDetailRoundIndexView.h"

#import "ZYPhotoBrowser.h"

@interface GoodsDetailImageScrollView()<UIScrollViewDelegate,HZPhotoBrowserDelegate>

@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)GoodsDetailRoundIndexView *pageIndexView;
@property (nonatomic,strong)UIImageView *singleImageView;

@property (nonatomic,strong)NSArray *imgUrls;

@end

@implementation GoodsDetailImageScrollView

#pragma mark -主界面
// 重新添加视图
- (void)resetViewsWithImageUrls:(NSArray *)imgUrls
{
    self.imgUrls = imgUrls;
    if (imgUrls.count > 1) {
        // 数据源大于1 轮询展示
        [self addScrollView];
    }else if(imgUrls.count == 1){
        // 数据源等于1 单图展示
        [self addSingleView];
    }
}
// 添加滚动视图
- (void)addScrollView
{
    // 移除旧视图
    [self.singleImageView removeFromSuperview];
    [self.mainScrollView removeFromSuperview];
    [self.pageIndexView removeFromSuperview];
    
    // 滑动视图
    UIScrollView *scrollPanel = [UIScrollView new];
    self.mainScrollView = scrollPanel;
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.showsHorizontalScrollIndicator = NO;
    scrollPanel.showsVerticalScrollIndicator = NO;
    scrollPanel.directionalLockEnabled = YES;
    scrollPanel.pagingEnabled = YES;
    scrollPanel.delegate = self;
    scrollPanel.scrollsToTop = NO;
    [self addSubview:scrollPanel];
    [scrollPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 页码器
    self.pageIndexView = [GoodsDetailRoundIndexView new];
    [self addSubview:self.pageIndexView];
    [self.pageIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-15);
    }];
    // 添加子视图
    [self addChildViews];
}
// 添加子视图
- (void)addChildViews
{
    // 先移除旧视图
    for (UIImageView *pageView in self.mainScrollView.subviews) {
        [pageView removeFromSuperview];
    }
    // 添加新视图
    NSInteger pageCount = self.imgUrls.count;
    
    UIView *lastPage = nil;
    for (int i = 0; i<pageCount; i++) {
        // 页视图
        NSString *imgUrl = [self.imgUrls objectAtIndex:i];
        UIImageView *singleImageView = [UIImageView new];
        [singleImageView ly_showMidImg:imgUrl];
        [self.mainScrollView addSubview:singleImageView];
        [singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(self.mainScrollView);
            }
            if (i == pageCount - 1) {
                make.right.mas_equalTo(self.mainScrollView);
            }
            make.top.bottom.width.height.mas_equalTo(self.mainScrollView);
            if (lastPage) {
                make.left.mas_equalTo(lastPage.right);
            }
        }];
        // 点击事件
        [self addClickActionWithImageView:singleImageView
                                    index:i];
        lastPage = singleImageView;
    }
    [self.pageIndexView setCurrentNumber:1
                             totalNumber:self.imgUrls.count];
}
// 添加单图
- (void)addSingleView
{
    // 移除旧视图
    [self.singleImageView removeFromSuperview];
    [self.mainScrollView removeFromSuperview];
    [self.pageIndexView removeFromSuperview];
    
    // 添加新视图
    NSString *imgUrl = [self.imgUrls firstObject];
    UIImageView *singleImageView = [UIImageView new];
    self.singleImageView = singleImageView;
    [self addSubview:singleImageView];
    [singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 点击事件
    [self addClickActionWithImageView:singleImageView
                                index:0];
    
    [singleImageView ly_showMidImg:imgUrl];
}
// 添加点击事件
- (void)addClickActionWithImageView:(UIImageView *)imageView
                              index:(NSInteger)index
{
    imageView.userInteractionEnabled = YES;
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [imageView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        ZYPhotoBrowser *browser = [[ZYPhotoBrowser alloc] init];
        browser.imageCount = self.imgUrls.count;
        browser.currentImageIndex = (int)index;
        browser.delegate = self;
        [browser show];
        return [RACSignal empty];
    }];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(ZYPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}

- (NSURL *)photoBrowser:(ZYPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self.imgUrls objectAtIndex:index]];
}

#pragma mark -ScrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    [self.pageIndexView setCurrentNumber:currentPage+1
                             totalNumber:self.imgUrls.count];
}

@end
