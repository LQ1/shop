//
//  DLLoadingSetting.h
//  Pods
//
//  Created by SL on 16/3/1.
//
//

#import <Foundation/Foundation.h>

@interface DLLoadingSetting : NSObject

+ (instancetype)sharedInstance;

/**
 *  加载框图片
 */
@property (nonatomic,strong) UIImage *loadingImg;

/**
 *  加载框color
 */
@property (nonatomic,strong) UIColor *loadingColor;

/**
 *  自动刷新table是否显示刷新时间
 */
@property (nonatomic,assign) BOOL autoTableShowTime;

/**
 *  UIWindow加载框LLARingSpinnerView属性设置
 */
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,assign) CGFloat loadingStart;
@property (nonatomic,strong) UIColor *bezierPathBgColor;

/**
 是否使用UIActivityIndicatorView动画效果
 */
@property (nonatomic,assign) BOOL activityIndicatorLoading;

/**
 新的loading方法，该类实现startAnimating和stopAnimating方法
 */
@property (nonatomic, strong) NSString *loadingClassName;
@property (nonatomic, strong) NSString *windowLFrame;
@property (nonatomic, strong) NSString *tableLFrame;

@end
