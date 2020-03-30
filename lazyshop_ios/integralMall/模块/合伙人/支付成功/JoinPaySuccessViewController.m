//
//  JoinPaySuccessViewController.m
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "JoinPaySuccessViewController.h"
#import "JoinPaySucTableViewController.h"
#import "UIColor+YYAdd.h"

@interface JoinPaySuccessViewController ()

@end

@implementation JoinPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"支付成功";
    
    [self initControl];
}

- (void)getData{
    
}

- (void)initControl{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    UITapGestureRecognizer *gesture_confirm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_confirm_onClicked:)];
    self.imgCommit.userInteractionEnabled = YES;
    [self.imgCommit addGestureRecognizer:gesture_confirm];
}

//确认提交
- (void)gesture_confirm_onClicked:(id)sender{
    NSArray *arrayViews = self.viewContainer.subviews;
    UITableView *tabView = [arrayViews firstObject];
    JoinPaySucTableViewController *joinPaySucTabViewCtrl = (JoinPaySucTableViewController*)tabView.dataSource;
    [joinPaySucTabViewCtrl btnChkAndSubmit];//提交数据
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
