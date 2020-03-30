//
//  GoodsDetailIntroWebView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroWebView.h"

@interface GoodsDetailIntroWebView()

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,copy)NSString *htmlString;

@end

@implementation GoodsDetailIntroWebView

- (instancetype)initWithHtmlString:(NSString *)htmlString
{
    self = [super init];
    if (self) {
        self.htmlString = htmlString;
        [self addViews];
        [self loadWebView];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 网页
    UIWebView *mainWebView = [UIWebView new];
    mainWebView.scalesPageToFit = YES;
    self.webView = mainWebView;
    [self addSubview:mainWebView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark -load
- (void)loadWebView
{
    // 加载前 先看 如果没有style 设置style
    NSRange styleRange = [self.htmlString rangeOfString:@"<style"];
    if (styleRange.location == NSNotFound) {
        NSString *styleStr = @" <style type=\"text/css\"> img{ width: 100%; height: auto; display: block; } </style> ";
        self.htmlString = [styleStr stringByAppendingString:self.htmlString];
    }
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
}

@end
