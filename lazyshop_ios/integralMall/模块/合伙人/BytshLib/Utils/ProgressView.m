//
//  ProgressView.m
//  EcologicalMgr
//
//  Created by haitao liu on 14-9-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ProgressView.h"


@implementation ProgressView
//@synthesize radialView;
@synthesize nCount;
@synthesize isInit;
@synthesize activityIndicatorView;
@synthesize viewAlpha;
@synthesize viewTip;

- (id)initActivWithViewAndFrame:(UIView*)view withFrame:(CGRect)frame
{
    [self setViewAndFrame:view withFrame:frame];
    return self;
}

- (void)setViewAndFrame:(UIView *)view withFrame:(CGRect)frame
{
    viewMain = view;
    isInit = YES;
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    viewAlpha = [[UIView alloc] initWithFrame:frame];
    viewAlpha.backgroundColor = [UIColor colorWithWhite:0 alpha:.1f];
    //viewAlpha.alpha = .4f;
    viewAlpha.hidden = YES;
    [view addSubview:viewAlpha];
    
    const int SIZE_H = 80;
    const int SIZE_W = 110;
    int nY = (frame.size.height - SIZE_H)*.5;
    
    viewIndicator = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - SIZE_W)*.5, nY, SIZE_W, SIZE_H - 30)];
    viewIndicator.backgroundColor = [UIColor blackColor];
    viewIndicator.layer.cornerRadius = 10;
    viewIndicator.layer.masksToBounds = YES;
    [viewAlpha addSubview:viewIndicator];
    
    CGRect rc = CGRectMake(0, 0, 50, 50);
    [activityIndicatorView setFrame:rc];
    [viewIndicator addSubview:activityIndicatorView];
    
    rc.origin.x = 45;
    rc.size.width = 105;
    lblText = [[UILabel alloc] initWithFrame:rc];
    lblText.backgroundColor = [UIColor clearColor];
    lblText.text = @"正在加载...";
    lblText.font = [UIFont fontWithName:@"Arial" size:12.0];
    lblText.textColor = [UIColor whiteColor];
    lblText.textAlignment = NSTextAlignmentLeft;
    [viewIndicator addSubview:lblText];
    
    rcViewIndOri = viewIndicator.frame;
}

#pragma mark - activityIndicator

//显示加载进度
- (void)showActivityIndicatorView:(NSString*)szTips{
    if (isInit) {
        lblText.text = szTips;
        viewAlpha.hidden = NO;
        [activityIndicatorView startAnimating];
        //15s后自动关闭，不管有没有加载好
        [self performSelector:@selector(closeActivityIndicator) withObject:nil afterDelay:15];
    }
}

- (void)showActivityIndicatorViewWithoutAutoClose:(NSString *)szTips{
    if (isInit) {
        lblText.text = szTips;
        viewAlpha.hidden = NO;
        [activityIndicatorView startAnimating];
    }
}

//关闭进度指示
- (void)closeActivityIndicator
{
    if (isInit) {
        viewAlpha.hidden = YES;
        [activityIndicatorView stopAnimating];
    }
}

//隐藏TIP
- (void)hiddenTip:(UIView *)viewTip1
{
    [viewTip1 removeFromSuperview];
    viewTip1 = nil;
}

//设置提示文字 简短的
- (void)setTips:(NSString*)szTips{
    int nW = 30;
    [viewIndicator setFrame:CGRectMake(rcViewIndOri.origin.x - nW*0.5, rcViewIndOri.origin.y, rcViewIndOri.size.width + nW, rcViewIndOri.size.height)];
    lblText.text = szTips;
}

//显示提示
- (void)showTip:(NSString *)szTipMsg
{
    if (viewTip) {
        [self hiddenTip:viewTip];
    }
    viewTip = [[UIView alloc] init];
    viewTip.backgroundColor = [UIColor colorWithWhite:0 alpha:.9];
    UIFont *font = [UIFont fontWithName:@"Arial" size:14.0f];
    CGSize size = [szTipMsg sizeWithFont:font constrainedToSize:CGSizeMake([Utility getScreenWidth] - 20, 50) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rcTip;
    rcTip.size.height = size.height + 20;
    rcTip.size.width = size.width + 30;
    rcTip.origin.x = (viewMain.frame.size.width - rcTip.size.width)*.5;
    rcTip.origin.y = (viewMain.frame.size.height - rcTip.size.height)*.5;
    [viewTip setFrame:rcTip];
    viewTip.layer.cornerRadius = 5.0f;
    viewTip.layer.masksToBounds =YES;
    [viewMain addSubview:viewTip];
    //[[UIApplication sharedApplication].keyWindow addSubview:viewTip];
    
    lblTip = [[UILabel alloc] init];
    [lblTip setFrame:CGRectMake(0, 0, rcTip.size.width, rcTip.size.height)];
    lblTip.backgroundColor = [UIColor clearColor];
    lblTip.text = szTipMsg;
    lblTip.textColor = [UIColor whiteColor];
    lblTip.textAlignment = NSTextAlignmentCenter;
    lblTip.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [viewTip addSubview:lblTip];
    
    //3s后关闭---只能在主线程才会执行
    [self performSelector:@selector(hiddenTip:) withObject:viewTip afterDelay:3.0];
}

- (void)showTipInBottom:(NSString*)szTipMsg
{
    if (viewTip) {
        [self hiddenTip:viewTip];
    }
    viewTip = [[UIView alloc] init];
    viewTip.backgroundColor = [UIColor colorWithWhite:0 alpha:.9];
    UIFont *font = [UIFont fontWithName:@"Arial" size:14.0f];
    CGSize size = [szTipMsg sizeWithFont:font constrainedToSize:CGSizeMake([Utility getScreenWidth] - 20, 50) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rcTip;
    rcTip.size.height = size.height + 20;
    rcTip.size.width = size.width + 30;
    rcTip.origin.x = (viewMain.frame.size.width - rcTip.size.width)*.5;
    rcTip.origin.y = viewMain.frame.size.height - rcTip.size.height - 20;
    [viewTip setFrame:rcTip];
    viewTip.layer.cornerRadius = 5.0f;
    viewTip.layer.masksToBounds =YES;
    
    [viewMain addSubview:viewTip];
    
    UILabel *lblTipBottom = [[UILabel alloc] init];
    //lblTip.numberOfLines = 0;
    [lblTipBottom setFrame:CGRectMake(0, 0, rcTip.size.width, rcTip.size.height)];
    lblTipBottom.backgroundColor = [UIColor clearColor];
    lblTipBottom.text = szTipMsg;
    lblTipBottom.textColor = [UIColor whiteColor];
    lblTipBottom.textAlignment = NSTextAlignmentCenter;
    lblTipBottom.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [viewTip addSubview:lblTipBottom];
    
    //3s后关闭---只能在主线程才会执行
    [self performSelector:@selector(hiddenTip:) withObject:viewTip afterDelay:3.0];
}

@end
















