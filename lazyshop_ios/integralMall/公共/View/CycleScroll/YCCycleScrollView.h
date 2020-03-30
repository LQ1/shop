//
//  PreloadScrollView.h
//  TsinghuaSNS
//  循环加载显示的的UIScrollView
//  Created by SL on 13-11-12.
//  Copyright (c) 2013年 cdeledu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCCycleScrollView : UIView

#pragma mark - required
/**
 *  设置当前显示页面总个数
 */
@property (nonatomic,assign) NSInteger totalNumber;

/**
 *  获取显示页面
 *
 *  @param page 页面位置，已0为起点，
 *
 *  @return view
 */
- (void)fetchShowView:(UIView *(^)(NSInteger page))page;

/**
 *  获取显示页面，子类可重写方法，否则没有显示，有上面方法此方法无效
 *
 *  @param page 页面位置，已0为起点
 *
 *  @return view
 */
- (UIView *)getShowView:(NSInteger)page;

/**
 *  当前显示位置，可设置或者获取
 *  一般第一次使用需要设置此值才能显示页面，执行上面方法之后执行有效
 */
@property (nonatomic,assign) NSInteger curPage;

#pragma mark - optional
/**
 *  点击页面，执行此方法可响应点击事件
 */
- (void)clickView:(void(^)(NSInteger page))page;

/**
 *  主页面
 */
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic, readonly) NSMutableDictionary *y_viewDic;

/**
 *  页面不需要缓存，默认是有缓存
 */
@property (nonatomic,assign) BOOL isNotCache;

/**
 *  页面自动切换，默认是没有切换的，在设置页面总个数方法下
 */
@property (nonatomic,assign) BOOL isAuto;

/**
 *  页面位置显示view
 */
@property (nonatomic,strong) UIPageControl *pageControl;

/**
 *  显示页面个数和标识，默认不显示
 */
@property (nonatomic,assign) BOOL isShowLoc;

@end
