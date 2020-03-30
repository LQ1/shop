//
//  PartnerSimpleIntroViewController.m
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "PartnerSimpleIntroViewController.h"
#import "RegPartnerViewController.h"

@interface PartnerSimpleIntroViewController ()

@end

@implementation PartnerSimpleIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"合伙人";
    self.webView.delegate = self;
    [self setBtnDisable:self.btnJoinPartner];
}

#pragma mark uiwebview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}


- (void)getData{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryInfo) withObject:nil];
}

//加入合伙人
- (IBAction)btnAddPartner:(id)sender {
    RegPartnerViewController *regPartnerViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RegPartnerViewController class])];
    regPartnerViewCtrl.propertyRefUsrId = self.propertyRefUsrId;
    [self.navigationController pushViewController:regPartnerViewCtrl animated:YES];
}

//查询数据
- (void)thread_queryInfo{
    PartnerPage1 *pp1 = [[DataViewModel getInstance] partnerIndex];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (pp1) {
            [self.webView loadHTMLString:pp1.content baseURL:nil];
            [self setBtnEnable:self.btnJoinPartner];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
}

@end
