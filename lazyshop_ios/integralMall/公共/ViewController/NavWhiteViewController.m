//
//  NavWhiteViewController.m
//  NetSchool
//
//  Created by SL on 2017/4/20.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "NavWhiteViewController.h"

@interface NavWhiteViewController ()

@end

@implementation NavWhiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.navigationBarView.leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    self.navigationBarView.titleLabel.textColor = [UIColor blackColor];
    [self.navigationBarView addBottomLineWithColorString:@"#cccccc"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
@end
