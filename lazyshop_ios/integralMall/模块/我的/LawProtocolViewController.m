//
//  LawProtocolViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LawProtocolViewController.h"

#import "LawProtocolViewModel.h"

@interface LawProtocolViewController ()

@end

@implementation LawProtocolViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindSignal];
}

- (void)requestUrl
{
    // 加载
    self.webView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

- (void)bindSignal
{
    @weakify(self);
    // 获取内容成功
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        self.navigationBarView.titleLabel.text = self.viewModel.title;
        self.staticNavTitle = self.viewModel.title;
        [self.webView loadHTMLString:self.viewModel.content baseURL:nil];
    }];
    
    // 获取内容失败
    [self.viewModel.errorSignal subscribeNext:^(NSError *x) {
        @strongify(self);
        self.navigationBarView.titleLabel.text = @"软件使用协议";
        self.staticNavTitle = @"软件使用协议";
            self.webView.scalesPageToFit=YES;//点击伸缩效果的
        NSString *documentLocation=[[NSBundle mainBundle]pathForResource:@"protocol" ofType:@"docx"];
        NSURL *myDocument=[NSURL fileURLWithPath:documentLocation];
        NSURLRequest *request=[NSURLRequest requestWithURL:myDocument];
        [self.webView loadRequest:request];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
