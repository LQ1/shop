//
//  CashierDeskViewController.m
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CashierDeskViewController.h"
#import "UIColor+YYAdd.h"
#import "CashierDeskTableViewController.h"



@interface CashierDeskViewController ()

@end

@implementation CashierDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"懒店收银台";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    UITapGestureRecognizer *gesture_confirm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_confirm_onClicked:)];
    self.imgConfirm.userInteractionEnabled = YES;
    [self.imgConfirm addGestureRecognizer:gesture_confirm];
    
     UITableView *tabView = [self.viewContainer.subviews objectAtIndex:0];
    CashierDeskTableViewController *cashierDeskTabViewCtrl = (CashierDeskTableViewController*)tabView.dataSource;
    cashierDeskTabViewCtrl.propertyPayInfo = self.propertyPayInfo;
}

- (void)getData{
    
}

//确认支付
- (void)gesture_confirm_onClicked:(id)sender{
    UITableView *tabView = [self.viewContainer.subviews objectAtIndex:0];
    CashierDeskTableViewController *cashierDeskTabViewCtrl = (CashierDeskTableViewController*)tabView.dataSource;
    cashierDeskTabViewCtrl.propertyPayInfo = self.propertyPayInfo;
    [cashierDeskTabViewCtrl doSumbit];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    if (self.isHiddenOfflinePayment) {
        [self.viewHeight setConstant:318-56];
    } else {
        [self.viewHeight setConstant:318];
    }
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
