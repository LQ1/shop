//
//  PreloadScrollView.m
//  TsinghuaSNS
//
//  Created by SL on 13-11-12.
//  Copyright (c) 2013年 cdeledu. All rights reserved.
//

#import "YCCycleScrollView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define CycleTotalNumber  3             //预加载view个数
#define SetViewTag(i)   56709+i         //设置view标志
#define GetViewTag(i)   i-56709         //获取view标志

typedef UIView *(^FetchPage)(NSInteger page);
typedef void (^ClickPage)(NSInteger page);

@interface YCCycleScrollView ()<UIScrollViewDelegate>{
    //需要removeFromSuperview的页面tag
    NSInteger _removeTag;
}

@property (nonatomic,copy) FetchPage pageBlock;
@property (nonatomic,strong) NSMutableDictionary *y_viewDic;

@property (nonatomic,copy) ClickPage clickPage;

@property (nonatomic,strong) RACDisposable *autoDis;

@end

@implementation YCCycleScrollView

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"dealloc -- %@",[self class]);
#endif
    self.mainScrollView.delegate = nil;
    [self.mainScrollView removeFromSuperview];
    self.mainScrollView = nil;
    
    [self.autoDis dispose];
    self.autoDis = nil;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         *  IOS7以上在viewDidLoad里面初始化此类会多出20像素的影响
         */
        UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.mainScrollView = mainScrollView;
        [mainScrollView setPagingEnabled:YES];
        [mainScrollView setShowsHorizontalScrollIndicator:NO];
        [mainScrollView setShowsVerticalScrollIndicator:NO];
        mainScrollView.scrollsToTop = NO;
        [self addSubview:mainScrollView];
                
        for (UIView *view in [mainScrollView subviews]) {
            [view removeFromSuperview];
        }
        _removeTag = -1;
        
        self.y_viewDic = [NSMutableDictionary new];
    }
    return self;
}

- (void)fetchShowView:(UIView *(^)(NSInteger page))page{
    self.pageBlock = page;
}

- (UIView *)getShowView:(NSInteger)page{
    return nil;
}

- (void)clickView:(void(^)(NSInteger page))page{
    self.clickPage = page;
}

- (void)setTotalNumber:(NSInteger)total{
    _totalNumber = total;
    //根据数据源设置mainScrollView的内容大小
    if (_totalNumber>=2) {
        [_mainScrollView setDelegate:self];
        [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.bounds.size.width*3, 0)];
    }
}

/**
 *  设置自动切换页面
 */
- (void)setIsAuto:(BOOL)isAuto{
    _isAuto = isAuto;
    if (self.totalNumber>1 && isAuto) {
        if (self.autoDis) {
            [self.autoDis dispose];
            self.autoDis = nil;
        }
        @weakify(self);
        self.autoDis = [[[RACSignal interval:3 onScheduler:[RACScheduler currentScheduler]]
                         takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
            @strongify(self);
            if (self.superview) {
                [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.frame.size.width*2, 0) animated:YES];
            }
        }];
    }else{
        [self.autoDis dispose];
        self.autoDis = nil;
    }
}

- (void)setIsShowLoc:(BOOL)isShowLoc{
    _isShowLoc = isShowLoc;
    
    if (isShowLoc) {
        @weakify(self);
        if (!self.pageControl) {
            //设置UIPageControl背景
            CGRect rect = self.bounds;
            rect.origin.y = rect.size.height - 22;
            rect.size.height = 20;
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
            self.pageControl = pageControl;
            pageControl.userInteractionEnabled = NO;
            pageControl.pageIndicatorTintColor = [CommUtls colorWithHexString:@"#FFFFFF"];
            pageControl.currentPageIndicatorTintColor = [CommUtls colorWithHexString:@"#E4393C"];
            [self addSubview:pageControl];
            [[RACObserve(self, curPage) skip:1] subscribeNext:^(id x) {
                @strongify(self);
                self.pageControl.currentPage = self.curPage;
            }];
        }
        if (self.totalNumber>1) {
            self.pageControl.hidden = NO;
            self.pageControl.numberOfPages = self.totalNumber;
        } else {
            self.pageControl.hidden = YES;
        }
    }else{
        [self.pageControl removeFromSuperview];
        self.pageControl = nil;
    }
}

/**
 *  获取新页面
 */
- (UIView *)yc_fetchView:(NSInteger)index{
    UIView *view = nil;
    NSString *key = [NSString stringWithFormat:@"%ld",(long)index];
    if (!_isNotCache) {
        view = self.y_viewDic[key];
    }
    if (!view) {
        if (self.totalNumber == 2 && index >= 10) {
            index-=10;
        }
        if (self.pageBlock) {
            view = self.pageBlock(index);
        }else{
            view = [self getShowView:index];
        }
        if (view && !_isNotCache) {
            self.y_viewDic[key] = view;
        }
    }
    if (self.clickPage && view && ![view viewWithTag:23490]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        view.userInteractionEnabled = YES;
        button.tag = 23490;
        button.frame = view.bounds;
        @weakify(self,button);
        button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self,button);
            UIView *view = button.superview;
            NSInteger tag = GetViewTag(view.tag);
            if (self.totalNumber == 2 && tag >= 10) {
                tag-=10;
            }
            self.clickPage(tag);
            return [RACSignal empty];
        }];
    }
    return view;
}

/**
 *  设置当前页面
 *
 *  @param page 页面位置
 */
- (void)setCurPage:(NSInteger)page{
    _curPage = page;
    
    switch (_totalNumber) {
        case 1:{
            //当前只有一个主页面,不循环显示
            UIView *v = [self yc_fetchView:0];
            [v setFrame:_mainScrollView.bounds];
            [v setTag:SetViewTag(0)];
            [_mainScrollView addSubview:v];
        }
            break;
        case 2:{
            //当前只有两个主页面
            [self loadData];
        }
            break;
        default:{
            //3个以上主页面
            [self loadMoreData];
        }
            break;
    }
}

//总页面有3个及以上
- (void)loadMoreData{
    //从scrollView上移除没有用的uiview
    NSArray *subViews = [_mainScrollView subviews];
    for (UIView *view in subViews) {
        int tag = (int)GetViewTag(view.tag);
        if (!(tag==_curPage || tag==[self validPageValue:_curPage-1] || tag==[self validPageValue:_curPage+1])){
            [view removeFromSuperview];
        }
    }
    
    //加载预加载以内题目
    for (int i = 0; i < CycleTotalNumber; i++) {
        
        //预加载题目的位置
        NSInteger number = _curPage-1+i;
        number = [self validPageValue:number];
        
        //取出当前题目
        UIView *v = [_mainScrollView viewWithTag:SetViewTag(number)];
        
        if (!v) {
            v = [self yc_fetchView:number];
            [v setTag:SetViewTag(number)];
            [_mainScrollView addSubview:v];
        }
        [v setFrame:CGRectMake(self.bounds.size.width*i, 0, self.frame.size.width,  self.frame.size.height)];
    }
    //_mainScrollView显示位置
    [_mainScrollView setContentOffset:CGPointMake(_mainScrollView.frame.size.width, 0)];
}

//总页面只有2个
- (void)loadData{
    //从scrollView上移除没有用的uiview
    for (UIView *view in [_mainScrollView subviews]) {
        //移除预加载以外题目
        [view removeFromSuperview];
    }
    
    //加载预加载以内题目
    for (int i = 0; i < CycleTotalNumber; i++) {
        
        //预加载题目的位置
        NSInteger number = _curPage-1+i;
        number = [self validPageValue:number];
        
        //取出当前题目
        UIView *v = [_mainScrollView viewWithTag:SetViewTag(number)];
        
        if (v) {
            number+=10;
            v = [_mainScrollView viewWithTag:SetViewTag(number)];
        }
        
        if (!v) {
            v = [self yc_fetchView:number];
            [_mainScrollView addSubview:v];
            [v setTag:SetViewTag(number)];
        }
        [v setFrame:CGRectMake(self.bounds.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
    }
    
    //mainScrollView显示位置
    [_mainScrollView setContentOffset:CGPointMake(_mainScrollView.frame.size.width, 0)];
}

/**
 *  设置当前页数
 */
- (NSInteger)validPageValue:(NSInteger)value{
    if(value == -1) value = _totalNumber - 1;
    if(value == _totalNumber) value = 0;
    
    return value;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)ScrollView{
    CGFloat width = self.frame.size.width;
    
    int x = ScrollView.contentOffset.x;
    
    //
    if(x >= (2*width)) {
        //往下翻
        _removeTag = 0;
        self.curPage = [self validPageValue:_curPage+1];
    }else if (x <= 0) {
        //往上翻
        _removeTag = 2;
        self.curPage = [self validPageValue:_curPage-1];
    }
}

@end
