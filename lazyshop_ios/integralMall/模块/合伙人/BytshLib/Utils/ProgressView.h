//
//  ProgressView.h
//  EcologicalMgr
//
//  Created by haitao liu on 14-9-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
//#import "MDRadialProgressLabel.h"
//#import "MDRadialProgressTheme.h"
//#import "MDRadialProgressView.h"
#import "Utility.h"

@interface ProgressView : NSObject{
    UILabel *lblText;
    UIView *viewMain;
    UILabel *lblTip;
    UIView *viewIndicator;
    CGRect rcViewIndOri;;
}
//@property(strong, nonatomic) MDRadialProgressView *radialView;
@property int nCount;
@property BOOL isInit;

@property(strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property(strong, nonatomic) UIView *viewAlpha;

@property(strong, nonatomic) UIView *viewTip;

- (id)initActivWithViewAndFrame:(UIView*)view withFrame:(CGRect)frame;
- (void)setViewAndFrame:(UIView*)view withFrame:(CGRect)frame;

- (void)showActivityIndicatorView:(NSString*)szTips;
- (void)showActivityIndicatorViewWithoutAutoClose:(NSString *)szTips;
- (void)closeActivityIndicator;

- (void)setTips:(NSString*)szTips;
//
- (void)hiddenTip:(UIView*)viewTip;
- (void)showTip:(NSString*)szTipMsg;
- (void)showTipInBottom:(NSString*)szTipMsg;
@end
