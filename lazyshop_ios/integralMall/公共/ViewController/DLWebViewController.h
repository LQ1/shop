//
//  DLWebViewController.h
//  MobileClassPhone
//
//  Created by LY on 16/12/16.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "NavigationBarController.h"

typedef BOOL (^webViewShouldLoadRequestBlock)(NSURLRequest *request,UIWebViewNavigationType navigationType);

@interface DLWebViewController : NavigationBarController

/**
 *  网页地址
 *  也可在initUrlString设置
 */
@property (nonatomic,copy       ) NSString                                                  *urlString;

/**
 *  设置固定导航栏标题
 *  如不设置使用网页title
 */
@property (nonatomic,copy       ) NSString                                                  *staticNavTitle;

/**
 *  webView
 */
@property (nonatomic,readonly   ) UIWebView                                                 *webView;

/**
 *  选传
 *  可通过改变此值控制界面的刷新
 */
@property (nonatomic, assign    ) BOOL                                                      hasAppered;

/**
 *  初始化网页地址 可供子类重写
 */
- (void)initUrlString;

/**
 *  初始化导航 可供子类重写
 */
- (void)initNav;

/**
 *  添加网页 可供子类重写
 */
-(void)addWebview;

/**
 *  开始加载网页
 */
- (void)requestUrl;

/*
 *  停止web加载
 */
- (void)stopWebLoading;

/**
 *  设置网页开始加载的回调
 */
- (void)setStartLoadBlock:(webViewShouldLoadRequestBlock)block;

#pragma mark - webView子类定制需求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(UIWebView *)webView;

@end
