//
//  WebViewController.m
//  integralMall
//
//  Created by liu on 2019/1/4.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBarView.titleLabel.text = @"懒店";
    //self.web.delegate = self;
    
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.propertyUrl]]];
}

//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    //[self.view DLLoadingInSelf];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    //[self.view DLLoadingHideInSelf];
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    //[self.view DLLoadingHideInSelf];
//    [DLLoading DLToolTipInWindow:@"加载失败!"];
//}

@end
