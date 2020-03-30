//
//  UIBaseViewController.h
//  HomeDecoration
//
//  Created by xtkj on 15/5/6.
//  Copyright (c) 2015年 anz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICommonNavigationBar.h"
#import "ProgressView.h"
#import "Utility.h"
#import "ColorUtils.h"
#import "UIColor+flat.h"
#import "ImageLoadingUtils.h"
#import "GlobalSetting.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "UIViewWithTouchEffect.h"
#import "UIViewAnimation.h"
#import "NSString+Extends.h"


@interface UIBaseViewController:UIViewController{
    UIView *viewLoading;

    NSTimer *_timer;
    int index1;
    UIViewAnimation *_viewAnimation;
}
@property int nPageNum;

@property UIView *forView;
@property(strong,nonatomic)ProgressView *progressView;

- (void)initControl;
- (void)initData;
- (void)initNavBar:(NSString*)szTitle;
- (void)initNavBar:(NSString *)szTitle withBackBlock:(BackReturnBlock)backReturnBlock;
- (void)initNavBarRightBtn:(NSString*)szRightText withClicked:(SEL)btnClicked;
- (void)initNavBarRightImg:(UIImage*)image withClicked:(SEL)btnClicked;

- (NSString*)getStringPageNum;

- (void)presentViewController:(UIViewController *)viewController;
- (void)presentViewController:(UIViewController *)viewController withAnimationType:(AnimationType)aniType;

- (void)setThinBorder:(UIView*)view;
- (void)setBtnDarkBackground:(UIButton*)btn;
- (void)setBtnLightBackground:(UIButton*)btn;
- (void)setBtnMasterBackground:(UIButton*)btn;
- (void)setAlphaBackground:(UIView*)view;

- (void)showProgressLoadingIndicator:(NSString*)szTips;
- (void)showProgressLoadingIndicatorWithoutAutoClose:(NSString*)szTips;
- (void)closeProgressLoadingIndicator;

- (void)showTipWithDismiss:(NSString*)szTipsMsg;
- (void)showTipInCenter:(NSString*)szTipMsg;
- (void)showTipInBottom:(NSString*)szTipMsg;


- (void)showHUDSuccess:(NSString*)szMsg;
- (void)showHUDFail:(NSString*)szMsg;
- (void)closeHUD;

@end
