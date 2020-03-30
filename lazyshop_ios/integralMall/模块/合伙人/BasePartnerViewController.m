//
//  BasePartnerViewController.m
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "BasePartnerViewController.h"

@interface BasePartnerViewController ()

@end

@implementation BasePartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustom];
}


- (void)getData{
    
}

- (void)bindSignal
{
    
}

- (void)setBtnDisable:(UIButton*)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor colorWithHexString:@"#CECECE"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
}

- (void)setBtnEnable:(UIButton*)btn{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#FF0000"];
}

//创建客服头像
- (void)createCustom{
    CreateCustomView *viewCustom = [[CreateCustomView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    viewCustom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    viewCustom.userInteractionEnabled = NO;
    [viewCustom initView:self.view];
    [self.view addSubview:viewCustom];
}

@end
