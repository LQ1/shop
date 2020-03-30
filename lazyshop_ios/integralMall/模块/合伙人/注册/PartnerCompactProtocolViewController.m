//
//  PartnerCompactProtocolViewController.m
//  integralMall
//
//  Created by lc on 2019/10/25.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "PartnerCompactProtocolViewController.h"
#import "DataViewModel.h"

@interface PartnerCompactProtocolViewController ()

@end

@implementation PartnerCompactProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestUrl];
}

- (void)requestUrl {
    // 加载
    self.webView.hidden = YES;
    [self.view DLLoadingInSelf];
    
    PartnerCompactProtocolModel *model = [[DataViewModel getInstance] getParterCompactProtocol];
    self.navigationBarView.titleLabel.text = model.title;
    self.staticNavTitle = model.title;
    [self.webView loadHTMLString:model.content baseURL:nil];
}


@end
