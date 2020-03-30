//
//  BaseTableViewController.h
//  netcomment
//
//  Created by liu on 2018/3/16.
//  Copyright © 2018年 xtkj. All rights reserved.
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

#define TAG  [self className]

@interface UIBaseTableViewController : UITableViewController{
    UIView *viewLoading;
    
    NSTimer *_timer;
    int index1;
    UIViewAnimation *_viewAnimation;
}

@property UIView *forView;
@property(strong,nonatomic)ProgressView *progressView;

- (void)initControl;
- (void)initData;
- (void)initNavBar:(NSString*)szTitle;
- (void)initNavBar:(NSString *)szTitle withBackBlock:(BackReturnBlock)backReturnBlock;
- (void)initNavBarRightBtn:(NSString*)szRightText withClicked:(SEL)btnClicked;
- (void)initNavBarRightImg:(UIImage*)image withClicked:(SEL)btnClicked;

- (void)presentViewController:(UIViewController *)viewController;
- (void)presentViewController:(UIViewController *)viewController withAnimationType:(AnimationType)aniType;


- (void)showProgressLoadingIndicator:(NSString*)szTips;
- (void)showProgressLoadingIndicatorWithoutAutoClose:(NSString*)szTips;
- (void)closeProgressLoadingIndicator;

- (void)showTipWithDismiss:(NSString*)szTipsMsg;
- (void)showTipInCenter:(NSString*)szTipMsg;
- (void)showTipInBottom:(NSString*)szTipMsg;

- (void)showHUDProgressLoadingIndicator:(NSString*)szTips;
- (void)showHUDSuccess:(NSString*)szMsg;
- (void)showHUDFail:(NSString*)szMsg;
- (void)closeHUD;

@end
